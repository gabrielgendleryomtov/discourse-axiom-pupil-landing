import { ajax } from "discourse/lib/ajax";
import DiscourseRoute from "discourse/routes/discourse";

/**
 * Pupil landing route model.
 */
export default class AxiomPupilLandingRoute extends DiscourseRoute {
  /**
   * Load direct destinations for the pupil's team channel and forum category.
   *
   * @returns {Promise<object>}
   */
  model() {
    return ajax("/axiom-pupil-landing/links.json");
  }
}
