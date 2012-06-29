namespace :db do

  desc 'Seed database from db/some_script.sql file, type rake db:sqlseed file=file_name.sql'
  task :sqlseed do
    config = Rails::Configuration.new.database_configuration[RAILS_ENV]
    file_name = ENV['file']
    seed_sql = File.expand_path(File.dirname(__FILE__) + "/../../db/#{file_name}")

    if !File.exists?(seed_sql)
      puts "Missing RAILS_ROOT/db/#{file_name}"
    else
      case config['adapter']
      when 'mysql'
        database = config['database']
        username = config['username']
        password = config['password']
        hostname = config['host']
        `mysql -h#{hostname} -D#{database} -u#{username} -p#{password} --default-character-set=utf8 < #{seed_sql}`
      when 'sqlite3'
        database = config['database']
        `sqlite3 #{database} < #{seed_sql}`
      else
        puts "Wrong adapter. Only MySQL and Sqlite3 are supported."
      end
    end
  end

end