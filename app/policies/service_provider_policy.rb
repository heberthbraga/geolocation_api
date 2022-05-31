class ServiceProviderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError unless user.admin?

      Cacher.fetch_cached_providers
    end
  end

  def create?
    admin?
  end

  def show?
    admin?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end
end