# frozen_string_literal: true

module System
  class LoadBalancerPolicy < ::RolePolicy
    section 'System/LoadBalancer'

    class Scope < ::RolePolicy::Scope
    end
  end
end
