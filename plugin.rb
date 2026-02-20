# frozen_string_literal: true

# name: axiom-landing
# about: Pupil landing page with direct links to team chat and forum category
# version: 0.1.0
# authors: Axiom Maths / Gabriel Gendler Yom-Tov
# url: https://axiommaths.com

enabled_site_setting :axiom_landing_enabled

register_asset "stylesheets/common/axiom-landing.scss"

require_relative "lib/axiom_landing/engine"
require_relative "config/routes"

after_initialize do
  next unless SiteSetting.axiom_landing_enabled

  require_relative "lib/axiom_landing/common"
  require_relative "lib/axiom_landing/home_resolver"
  require_relative "app/controllers/axiom_landing/landing_controller"

  add_to_serializer(:current_user, :axiom_landing_home_url) do
    ::AxiomLanding::HomeResolver.home_url_for(object)
  end
end
