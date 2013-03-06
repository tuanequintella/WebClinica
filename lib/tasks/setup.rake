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
  admin.activate!
  
  if(admin.save)
    puts "Usuario \"#{username}\" criado com sucesso."
  else
    puts "Erro na criacao do usuario. " + admin.errors.messages
  end
end

desc "Criando a clinica"
task :create_office => :environment do
  puts "Nome:"
  name = STDIN.gets.strip
  puts "E-mail:"
  email = STDIN.gets.strip
  puts "Endereco:"
  address = STDIN.gets.strip
  puts "Telefone:"
  phone = STDIN.gets.strip


  office = Office.new(:name => name, :email => email, :address => address, :phone => phone)

  if(office.save)
    puts "Clinica \"#{name}\" criada com sucesso."
  else
    puts "Erro na criacao da clinica. " + office.errors.messages
  end

end
