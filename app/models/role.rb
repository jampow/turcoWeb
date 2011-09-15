class Role < ActiveRecord::Base
  acts_as_authorization_role

  has_and_belongs_to_many :users

  ROLES = {:clients       => 'Clientes',
           :departments   => 'Departamentos',
           :dept_contacts => 'Departamentos dos contatos',
           :func_contacts => 'Funções dos contatos',
           :messages      => 'Mensagens',
           :ncms          => 'NCM\'s',
           :permissions   => 'Permissões',
           :providers     => 'Fornecedores',
           :terms         => 'Termos',
           :users         => 'Usuários'
           }

  def self.roles
    ROLES
  end
end

