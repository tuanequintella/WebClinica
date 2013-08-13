#encoding: utf-8
namespace :populate do
  desc "Cria todos os dados de base da aplicação"
  task :all => :environment do
    Rake::Task['populate:admin_user'].invoke
    Rake::Task['populate:office'].invoke
    Rake::Task['populate:health_insurances'].invoke
    Rake::Task['populate:occupations'].invoke
  end

  desc "Cria o administrador inicial"
  task :admin_user => :environment do
    puts 'Criando administrador inicial...'
    user = Admin.new(:name => "Administrador do Sistema", :username=>"admin", :email=>"q.tuane@gmail.com", :password => "123456", :password_confirmation => "123456", :active => true)
    user.save
    puts user.errors.full_messages
  end


  desc "Cria clínica base do sistema"
  task :office => :environment do
    puts 'Criando a Clínica Crescere...'
    office = Office.new(:name => "Clínica Crescere", :email => "clinica@email.com", :address => "R. das Margaridas, 356 - Campinas, SP", :phone => "19 3255-4456")
    office.save
    puts office.errors.full_messages
  end

  desc 'Cria convênios'
  task :health_insurances => :environment do
    puts 'Criando convênios aceitos...'
    HealthInsurance.create(:name => 'Sem convênio (particular)')
    HealthInsurance.create(:name => 'Assimédica')
    HealthInsurance.create(:name => 'Cassi')
    HealthInsurance.create(:name => 'Unimed')
    HealthInsurance.create(:name => 'Bradesco Saúde')
    HealthInsurance.create(:name => 'Amil')
  end
  
  desc 'Cria especialidades'
  task :occupations => :environment do
    puts 'Criando especialidades...'
    Occupation.create(:name => 'Pediatria')
    Occupation.create(:name => 'Pneumologia')
    Occupation.create(:name => 'Fisioterapia')
    Occupation.create(:name => 'Fonoaudiologia')
    Occupation.create(:name => 'Psicologia')
  end
end
