# frozen_string_literal: true

module ::AxiomLanding
  module_function

  def enabled?
    SiteSetting.axiom_landing_enabled
  end

  def pupil_group_ids
    SiteSetting.axiom_landing_pupil_groups_map
  end

  def pupil?(user)
    return false if user.blank?
    return false if pupil_group_ids.blank?

    GroupUser.exists?(group_id: pupil_group_ids, user_id: user.id)
  end

  def landing_pupil?(user)
    enabled? && pupil?(user)
  end
end
