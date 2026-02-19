# frozen_string_literal: true

# name: axiom-pupil-landing
# about: Pupil landing page with direct links to team chat and forum category
# version: 0.1.0
# authors: Axiom Maths / Gabriel Gendler Yom-Tov
# url: https://axiommaths.com

enabled_site_setting :axiom_pupil_landing_enabled

register_asset "stylesheets/common/axiom-pupil-landing.scss"

require_relative "lib/axiom_pupil_landing/engine"
require_relative "config/routes"

after_initialize do
  next unless SiteSetting.axiom_pupil_landing_enabled

  require_relative "lib/axiom_pupil_landing/common"
  require_relative "app/controllers/axiom_pupil_landing/landing_controller"
end
