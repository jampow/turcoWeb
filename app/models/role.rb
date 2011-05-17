class Role < ActiveRecord::Base
  acts_as_authorization_role

  has_and_belongs_to_many :users

  ROLES = {:departments => 'Departamentos',
           :ncms        => 'NCM\'s',
           :permissions => 'Permissões',
           :users       => 'Usuários'
           }


  def self.roles
    ROLES
  end
end

