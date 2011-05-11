class Role < ActiveRecord::Base
  acts_as_authorization_role

  ROLES = {:departments => 'Departamentos',
           :permissions => 'Permissões',
           :users       => 'Usuários',
           :ncms        => 'NCM\'s',
           }


  def self.roles
    ROLES
  end
end

