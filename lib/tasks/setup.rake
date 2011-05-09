namespace :database do

  desc 'reseta base de dados e cria usuário para acesso'
  task :reset => ['db:drop', 'db:create', 'db:migrate', 'environment'] do
    user = User.create! do |u|
      u.login    = 'gian'
      u.name     = 'Gianpaulo M. Soares'
      u.email    = 'jam_pow@hotmail.com'
      u.password = '123456'
      u.password_confirmation = '123456'
    end
    user.has_role! :master
    puts 'Novo usuário criado'
    puts 'Username: ' << user.login
    puts 'Email   : ' << user.email
    puts 'Password: ' << user.password

  end

end

