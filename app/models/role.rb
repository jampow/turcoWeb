class Role < ActiveRecord::Base
  acts_as_authorization_role

  ROLES = {:departments => 'Departamentos',
             :permissions => 'Permissões'}


  def self.roles
    ROLES
  end
end

