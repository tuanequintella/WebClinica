#encoding: utf-8
namespace :setup do
  desc "Chama todos os scripts de setup"
  task :all => :environment do
    Rake::Task['setup:admin'].invoke
    Rake::Task['setup:office'].invoke
  end

  desc "Criando um admin inicial"
  task :admin => :environment do
    puts "\nCRIAR / ATUALIZAR ADMIN\n"
    puts "Nome:"
    name = STDIN.gets.strip
    puts "E-mail: "
    email = STDIN.gets.strip
    puts "Nome de usuario: "
    username = STDIN.gets.strip
    puts "Senha: "
    password = STDIN.gets.strip

    admin = Admin.where(:username=>username).first_or_create
    admin.update_attributes(:name => name, :email=>email, :password => password, :password_confirmation => password)
    admin.activate!
    
    if(admin.save)
      puts "Usuario \"#{username}\" criado/atualizado com sucesso."
    else
      puts "Erro na criação/atualização do usuario. " + admin.errors.messages
    end
  end

  desc "Criando a clinica"
  task :office => :environment do
    puts "\nCRIAR / ATUALIZAR CLINICA\n"
    puts "Nome:"
    name = STDIN.gets.strip
    puts "E-mail:"
    email = STDIN.gets.strip
    puts "Endereco:"
    address = STDIN.gets.strip
    puts "Telefone:"
    phone = STDIN.gets.strip


    office = Office.first_or_initialize
    office.update_attributes(:name => name, :email => email, :address => address, :phone => phone)

    if(office.save)
      puts "Clinica \"#{name}\" criada/atualizada com sucesso."
    else
      puts "Erro na criação/atualização da clinica. " + office.errors.messages
    end
  end

end
