#encoding: utf-8
namespace :populate do
  desc "Cria dados para teste"
  task :all_tests => :environment do
    Rake::Task['populate:test_secretaries'].invoke
    Rake::Task['populate:test_doctors'].invoke
    Rake::Task['populate:test_pacients'].invoke
  end

  desc "Cria pacientes para teste"
  task :test_pacients => :environment do
    puts 'Criando pacientes de teste...'
    pac = Pacient.create(:name => 'João da Silva', :birthdate => 3.years.ago, :address => "R. dos Alfeneiros, 4 - Campinas, SP", :phone => "(19) 3255-7896", :email => "marcossilva@email.com", :parent_name => "Marcos Silva", :parent_rg => "34343434-54", :parent_cpf => "39208032809", :health_insurance => HealthInsurance.where(:name => 'Unimed').first)
    pac.record = Record.create(:status => Record::NEW)
    pac.save
    
    pac = Pacient.create(:name => 'Maria dos Santos', :birthdate => 5.years.ago, :address => "Av. Carlos Grimaldi, 170 - Campinas, SP", :phone => "(19) 3200-9567", :email => "solangesantos@email.com", :parent_name => "Solange Santos", :parent_rg => "65656565-56", :parent_cpf => "39208032809", :health_insurance => HealthInsurance.where(:name => 'Cassi').first)
    pac.record = Record.create(:status => Record::REGULAR)
    pac.save
    app = Appointment.create(:record => pac.record, :scheduled_at => 29.days.ago)
    app.save
    pac.record.last_appointment = app
    pac.record.save

    pac = Pacient.create(:name => 'Cristina Silva Almeida', :birthdate => 10.years.ago, :address => "Largo das Flores, 83 - Campinas, SP", :phone => "(19) 3255-0009", :email => "fabioalmeida@email.com", :parent_name => "Fábio Almeida", :parent_rg => "665749382-66", :parent_cpf => "39208032809", :health_insurance => HealthInsurance.where(:name => 'Amil').first)
    pac.record = Record.create(:status => Record::REGULAR)
    pac.save
    app = Appointment.create(:record => pac.record, :scheduled_at => 40.days.ago)
    app.save
    pac.record.last_appointment = app
    pac.record.save
  end

  desc "Cria secretárias para teste"
  task :test_secretaries => :environment do
    puts 'Criando secretárias de teste...'
      
    user = Secretary.new(:name => "Secretária Teste 1", :username=>"secretaria1", :email=>"secretaria1@email.com", :password => "123456", :password_confirmation => "123456", :rg=>"45888488", :cpf=>"39208032809", :birthdate=>34.years.from_now, :active => true)
    user.save
    puts user.errors.full_messages 
  end
  
  desc "Cria médicos para teste"
  task :test_doctors => :environment do
    puts 'Criando médicos de teste...'
    
    user = Doctor.new(:name => "Doutor Teste 1", :username=>"doutor1", :email=>"doutor1@email.com", :password => "123456", :password_confirmation => "123456", :rg=>"32546788", :cpf=>"39208032809", :birthdate=>50.years.from_now, :crm=>"24000", :appointmentprice=>"180", :gradyear => 35.years.ago,:active => true)
    user.health_insurances << HealthInsurance.where(:name => 'Sem convênio (particular)')
    user.health_insurances << HealthInsurance.where(:name => 'Unimed')
    user.health_insurances << HealthInsurance.where(:name => 'Bradesco Saúde')
    user.health_insurances << HealthInsurance.where(:name => 'Amil')
    
    user.agenda = Agenda.new(:default_meeting_length=> 20)
    
    day = AvailableDay.new(:day=>1, :work_start_time=>Date.today.beginning_of_day + 9.hours, :work_end_time=>Date.today.beginning_of_day + 17.hours, :interval_start_time=>Date.today.beginning_of_day + 12.hours, :interval_end_time=>Date.today.beginning_of_day + 14.hours)
    
    user.agenda.available_days<< day
    
    day = AvailableDay.new(:day=>3, :work_start_time=>Date.today.beginning_of_day + 9.hours, :work_end_time=>Date.today.beginning_of_day + 17.hours, :interval_start_time=>Date.today.beginning_of_day + 12.hours, :interval_end_time=>Date.today.beginning_of_day + 14.hours)
    
    user.agenda.available_days<< day
    
    day = AvailableDay.new(:day=>4, :work_start_time=>Date.today.beginning_of_day + 9.hours, :work_end_time=>Date.today.beginning_of_day + 17.hours, :interval_start_time=>Date.today.beginning_of_day + 12.hours, :interval_end_time=>Date.today.beginning_of_day + 14.hours)
    
    user.agenda.available_days<< day
    user.save
    puts user.errors.full_messages
    
    user = Doctor.new(:name => "Doutor Teste 2", :username=>"doutor2", :email=>"doutor2@email.com", :password => "123456", :password_confirmation => "123456", :rg=>"45625488", :cpf=>"39208032809", :birthdate=>42.years.from_now, :crm=>"30500", :appointmentprice=>"150", :gradyear => 27.years.ago, :active => true)
    user.health_insurances << HealthInsurance.where(:name => 'Sem convênio (particular)')
    user.health_insurances << HealthInsurance.where(:name => 'Unimed')
    user.health_insurances << HealthInsurance.where(:name => 'Cassi')
    
    user.agenda = Agenda.new(:default_meeting_length=> 35)
    
    day = AvailableDay.new(:day=>2, :work_start_time=>Date.today.beginning_of_day + 8.hours, :work_end_time=>Date.today.beginning_of_day + 15.hours, :interval_start_time=>Date.today.beginning_of_day + 12.hours, :interval_end_time=>Date.today.beginning_of_day + 13.hours)
    
    user.agenda.available_days<< day
    
    day = AvailableDay.new(:day=>4, :work_start_time=>Date.today.beginning_of_day + 10.hours, :work_end_time=>Date.today.beginning_of_day + 16.hours, :interval_start_time=>Date.today.beginning_of_day + 12.hours, :interval_end_time=>Date.today.beginning_of_day + 13.hours)
    
    user.agenda.available_days<< day
    
    day = AvailableDay.new(:day=>5, :work_start_time=>Date.today.beginning_of_day + 9.hours, :work_end_time=>Date.today.beginning_of_day + 16.hours, :interval_start_time=>Date.today.beginning_of_day + 12.hours, :interval_end_time=>Date.today.beginning_of_day + 13.hours)
    
    user.agenda.available_days<< day
    user.save
    puts user.errors.full_messages
  end 
end
