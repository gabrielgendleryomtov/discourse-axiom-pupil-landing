# frozen_string_literal: true

module ::AxiomLanding
  class LandingController < ::ApplicationController
    requires_plugin "axiom-landing"

    before_action :ensure_logged_in
    before_action :ensure_plugin_enabled
    before_action :ensure_pupil

    def links
      render_json_dump(team: team_link, forum: forum_link)
    end

    private

    def ensure_plugin_enabled
      raise Discourse::InvalidAccess unless ::AxiomLanding.enabled?
    end

    def ensure_pupil
      raise Discourse::InvalidAccess unless ::AxiomLanding.landing_pupil?(current_user)
    end

    def guardian
      @guardian ||= Guardian.new(current_user)
    end

    def team_link
      return nil unless SiteSetting.chat_enabled
      return nil unless defined?(::Chat::ChannelFetcher)

      channel = ::Chat::ChannelFetcher.secured_public_channels(guardian, following: false).first
      return nil unless channel

      { name: channel.name, url: channel.relative_url }
    end

    def forum_link
      category = Category.post_create_allowed(guardian).order(:id).first
      return nil unless category

      { name: category.name, url: category.url }
    end
  end
end
