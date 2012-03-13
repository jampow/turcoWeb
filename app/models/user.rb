class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.logged_in_timeout = 5.minute
  end

  acts_as_authorization_subject

  has_and_belongs_to_many :roles

  validates_uniqueness_of :login

  def self.get_level(controller)
    qry = <<-QRY
           select rol.name
             from users       usr join
                  roles_users rus on rus.user_id = usr.id join
                  roles       rol on rol.id = rus.role_id
            where usr.id = #{current_user.id}
              and rol.name like '#{controller}%'"
          QRY
    level = Role.find_by_sql(qry).name
    level.split('_').last
  end
end

