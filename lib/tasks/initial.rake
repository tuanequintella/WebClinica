desc "Criando um admin inicial"
task :create_admin => :environment do
  puts "Nome:"
  name = STDIN.gets.strip
  puts "E-mail: "
  email = STDIN.gets.strip
  puts "Nome de usuario: "
  username = STDIN.gets.strip
  puts "Senha: "
  password = STDIN.gets.strip

  admin = Admin.new(:name => name, :username=>username, :email=>email, :password => password, :password_confirmation => password)

  if(admin.save)
    puts "Usuario \"#{username}\" criado com sucesso."
  else
    puts "Erro na criacao do usuario. Tente novamente."
  end

end
