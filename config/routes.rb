# frozen_string_literal: true

AxiomLanding::Engine.routes.draw { get "/links" => "landing#links" }

Discourse::Application.routes.append do
  unless Discourse::Application.routes.named_routes.key?("axiom_landing")
    mount ::AxiomLanding::Engine, at: "/axiom-landing"
  end
end
