desc "Criando um admin inicial"
task :populate_with_tests => :environment do
  begin
    user = Admin.new(:name => "Admin Teste 1", :username=>"admin1", :email=>"admin1@email.com", :password => "admin111", :password_confirmation => "admin111")
    user.save
    
    user = Doctor.new(:name => "Doutor Teste 1", :username=>"doutor1", :email=>"doutor1@email.com", :password => "doutor111", :password_confirmation => "doutor111", :rg=>"32546788", :cpf=>"39208032809", :birthdate=>50.years.from_now, :crm=>"24000")
    
    user.agenda = Agenda.new(:default_meeting_length=> 20)
    
    day = AvailableDay(:day=>2, :work_start_time=>Date.today.beginning_of_day + 9.hours, :work_end_time=>Date.today.beginning_of_day + 17.hours, :interval_start_time=>Date.today.beginning_of_day + 12.hours, :interval_end_time=>Date.today.beginning_of_day + 14.hours)
    
    user.agenda.available_days<< day
    
    day = AvailableDay(:day=>4, :work_start_time=>Date.today.beginning_of_day + 9.hours, :work_end_time=>Date.today.beginning_of_day + 17.hours, :interval_start_time=>Date.today.beginning_of_day + 12.hours, :interval_end_time=>Date.today.beginning_of_day + 14.hours)
    
    user.agenda.available_days<< day
    
    day = AvailableDay(:day=>5, :work_start_time=>Date.today.beginning_of_day + 9.hours, :work_end_time=>Date.today.beginning_of_day + 17.hours, :interval_start_time=>Date.today.beginning_of_day + 12.hours, :interval_end_time=>Date.today.beginning_of_day + 14.hours)
    
    user.agenda.available_days<< day
    user.save
    
    user = Doctor.new(:name => "Doutor Teste 2", :username=>"doutor2", :email=>"doutor2@email.com", :password => "doutor222", :password_confirmation => "doutor222", :rg=>"45625488", :cpf=>"39208032809", :birthdate=>42.years.from_now, :crm=>"30500")
    
    user.agenda = Agenda.new(:default_meeting_length=> 35)
    
    day = AvailableDay(:day=>3, :work_start_time=>Date.today.beginning_of_day + 8.hours, :work_end_time=>Date.today.beginning_of_day + 15.hours, :interval_start_time=>Date.today.beginning_of_day + 12.hours, :interval_end_time=>Date.today.beginning_of_day + 13.hours)
    
    user.agenda.available_days<< day
    
    day = AvailableDay(:day=>5, :work_start_time=>Date.today.beginning_of_day + 10.hours, :work_end_time=>Date.today.beginning_of_day + 16.hours, :interval_start_time=>Date.today.beginning_of_day + 12.hours, :interval_end_time=>Date.today.beginning_of_day + 13.hours)
    
    user.agenda.available_days<< day
    
    day = AvailableDay(:day=>6, :work_start_time=>Date.today.beginning_of_day + 9.hours, :work_end_time=>Date.today.beginning_of_day + 16.hours, :interval_start_time=>Date.today.beginning_of_day + 12.hours, :interval_end_time=>Date.today.beginning_of_day + 13.hours)
    
    user.agenda.available_days<< day
    user.save
    
    user = Secretary.new(:name => "Secretária Teste 1", :username=>"secretaria1", :email=>"secretaria1@email.com", :password => "secretaria111", :password_confirmation => "secretaria111", :rg=>"45888488", :cpf=>"39208032809", :birthdate=>34.years.from_now)
    user.save
    
    office = Office.new(:name => "Clinica Crescere", :email => "clinica@email.com", :address => "R. das Margaridas, 356 - Campinas, SP", :phone => "19 3255-4456")
    office.save
    
  rescue Exception => ex
    puts "Erro ao criar cadastros testes! " + ex.message
  end

end
