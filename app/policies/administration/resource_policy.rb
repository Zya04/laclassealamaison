class Administration::ResourcePolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def update?
    user.admin?
  end

  class Scope < Scope
    def resolve
      Resource
    end
  end
end
