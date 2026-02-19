# frozen_string_literal: true

AxiomPupilLanding::Engine.routes.draw { get "/links" => "landing#links" }

Discourse::Application.routes.append do
  unless Discourse::Application.routes.named_routes.key?("axiom_pupil_landing")
    mount ::AxiomPupilLanding::Engine, at: "/axiom-pupil-landing"
  end
end
