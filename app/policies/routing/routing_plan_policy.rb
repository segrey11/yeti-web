# frozen_string_literal: true

module Routing
  class RoutingPlanPolicy < ::RolePolicy
    section 'Routing/RoutingPlan'

    class Scope < ::RolePolicy::Scope
    end
  end
end
