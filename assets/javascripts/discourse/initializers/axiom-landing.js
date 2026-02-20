import { withPluginApi } from "discourse/lib/plugin-api";
import DiscourseURL from "discourse/lib/url";
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
function isHomeRouteName(routeName) {
  if (HOMEPAGE_ROUTES.has(routeName)) {
    return true;
  }

  const homepage = defaultHomepage();
  return !!homepage && routeName === `discovery.${homepage}`;
}

/**
 * Return the role-based home URL for the current user.
 *
 * @param {object} currentUser
 * @returns {string|null}
 */
function homeUrlForUser(currentUser) {
  return (
    currentUser?.axiom_landing_home_url ||
    currentUser?.axiomLandingHomeUrl ||
    null
  );
}

/**
 * Redirect configured users to their role-based home page from core home routes.
 */
export default {
  name: "axiom-landing",

  /**
   * Set up route-change redirects for eligible users.
   *
   * @param {object} owner
   */
  initialize(owner) {
    const siteSettings = owner.lookup("service:site-settings");
    const currentUser = owner.lookup("service:current-user");
    const router = owner.lookup("service:router");

    if (!siteSettings?.axiom_landing_enabled || !currentUser || !router) {
      return;
    }

    const userHomeUrl = homeUrlForUser(currentUser);
    if (!userHomeUrl) {
      return;
    }

    withPluginApi((api) => {
      api.registerHomeLogoHrefCallback(() => userHomeUrl);
    });

    router.on("routeDidChange", (transition) => {
      const toRouteName = transition?.to?.name;
      if (!toRouteName || toRouteName.startsWith("axiomLanding")) {
        return;
      }

      if (!isHomeRouteName(toRouteName)) {
        return;
      }

      DiscourseURL.routeTo(userHomeUrl);
    });
  },
};
