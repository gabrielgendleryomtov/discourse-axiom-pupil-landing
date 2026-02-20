# frozen_string_literal: true

module ::AxiomLanding
  module HomeResolver
    module_function

    def home_url_for(user)
      staff_chat_home_url_for(user) || pupil_home_url_for(user)
    end

    def staff_chat_home_url_for(user)
      return nil if user.blank?
      return nil unless user.staff?
      return nil unless SiteSetting.chat_enabled
      return nil unless defined?(::Chat::Channel)

      staff_category_id = SiteSetting.staff_category_id.to_i
      return nil if staff_category_id <= 0

      channel = ::Chat::Channel.find_by(chatable_type: "Category", chatable_id: staff_category_id)
      return nil if channel.blank?

      guardian = Guardian.new(user)
      return nil unless guardian.can_join_chat_channel?(channel)

      channel.relative_url
    end

    def pupil_home_url_for(user)
      "/landing" if ::AxiomLanding.landing_pupil?(user)
    end
  end
end
