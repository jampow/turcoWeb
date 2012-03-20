namespace :database do

  desc 'reseta base de dados com base no schema.rb, roda seeds.rb e cria usuário para acesso'
  task :reset => ['db:reset', 'database:create_user'] do
  end
  
  desc 'reseta base de dados rodando todas as migrações e cria usuário para acesso'
  task :recreate => ['db:drop', 'db:create', 'db:migrate', 'database:create_user'] do
  end

  desc 'Cria usuário master para acesso'
  task :create_user => ['environment'] do
    user = User.create! do |u|
      u.login    = 'gian'
      u.name     = 'Gianpaulo M. Soares'
      u.email    = 'jam_pow@hotmail.com'
      u.password = '123456'
      u.password_confirmation = '123456'
    end
    user.has_role! :master
    user.has_role! :permissions_e
    puts 'Novo usuário criado'
    puts 'Username: ' << user.login
    puts 'Email   : ' << user.email
    puts 'Password: ' << user.password
  end

end

