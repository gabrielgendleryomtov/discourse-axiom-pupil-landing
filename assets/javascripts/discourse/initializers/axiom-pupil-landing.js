import { withPluginApi } from "discourse/lib/plugin-api";
import { defaultHomepage } from "discourse/lib/utilities";

const HOMEPAGE_ROUTES = new Set([
  "discovery",
  "discovery.index",
  "discovery.latest",
  "discovery.new",
  "discovery.unread",
  "discovery.top",
  "discovery.hot",
  "discovery.unseen",
  "discovery.posted",
  "discovery.categories",
]);

/**
 * Parse a group-list setting into unique numeric IDs.
 *
 * @param {string} rawSetting
 * @returns {number[]}
 */
function parseGroupIds(rawSetting) {
  return (rawSetting || "")
    .split("|")
    .map((id) => Number(id))
    .filter(
      (id, index, ids) =>
        Number.isInteger(id) && id > 0 && ids.indexOf(id) === index
    );
}

/**
 * Extract numeric group IDs from the current user model.
 *
 * @param {object} currentUser
 * @returns {number[]}
 */
function currentUserGroupIds(currentUser) {
  return (currentUser?.groups || [])
    .map((group) => Number(group?.id))
    .filter(
      (id, index, ids) =>
        Number.isInteger(id) && id > 0 && ids.indexOf(id) === index
    );
}

/**
 * Return true when the current user is in any configured pupil group.
 *
 * @param {object} currentUser
 * @param {object} siteSettings
 * @returns {boolean}
 */
function isCurrentUserPupil(currentUser, siteSettings) {
  const pupilGroupIds = parseGroupIds(
    siteSettings?.axiom_pupil_landing_pupil_groups
  );
  if (!pupilGroupIds.length) {
    return false;
  }

  const userGroupIds = currentUserGroupIds(currentUser);
  return userGroupIds.some((id) => pupilGroupIds.includes(id));
}

/**
 * Return true when a route name represents a "home" destination.
 *
 * @param {string} routeName
 * @returns {boolean}
 */
function isHomeRouteName(routeName) {
  if (HOMEPAGE_ROUTES.has(routeName)) {
    return true;
  }

  const homepage = defaultHomepage();
  return !!homepage && routeName === `discovery.${homepage}`;
}

/**
 * Redirect configured pupils to the landing page from core home routes.
 */
export default {
  name: "axiom-pupil-landing",

  /**
   * Set up route-change redirects for eligible pupil users.
   *
   * @param {object} owner
   */
  initialize(owner) {
    const siteSettings = owner.lookup("service:site-settings");
    const currentUser = owner.lookup("service:current-user");
    const router = owner.lookup("service:router");

    if (!siteSettings?.axiom_pupil_landing_enabled || !currentUser || !router) {
      return;
    }

    if (!isCurrentUserPupil(currentUser, siteSettings)) {
      return;
    }

    withPluginApi((api) => {
      api.registerHomeLogoHrefCallback(() => "/pupil-landing");
    });

    router.on("routeDidChange", (transition) => {
      const toRouteName = transition?.to?.name;
      if (!toRouteName || toRouteName.startsWith("axiomPupilLanding")) {
        return;
      }

      if (!isHomeRouteName(toRouteName)) {
        return;
      }

      router.transitionTo("axiomPupilLanding");
    });
  },
};
