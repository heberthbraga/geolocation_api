class GeolocationPolicy < ApplicationPolicy
  def create?
    api?
  end

  def show?
    api?
  end

  def destroy?
    api?
  end
end