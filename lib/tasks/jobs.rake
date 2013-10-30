#encoding: utf-8
namespace :jobs do
  desc "Atualiza status dos prontuários"
  task :update_records => :environment do
    count = 0
    Record.where("status IN ('regular','beginner','new')").each do |record|
      if (record.pacient.age[:years] < 4)
        if (record.appointments.empty?)
          if (record.created_at < 2.years.ago)
            record.deactivate!
            Rails.logger.info("Record " + ("%4d"%record.id) + ", pacient " +
                              record.pacient.name + " deactivated by 2 year inactivity")
            count = count + 1
          end
        elsif (record.appointments.last.scheduled_at < 2.years.ago)
          record.deactivate!
          Rails.logger.info("Record " + ("%4d"%record.id) + ", pacient " +
                            record.pacient.name + " deactivated by 2 year inactivity")
          count = count + 1
        end
      else
        if (record.appointments.empty?)
          if (record.created_at < 5.years.ago)
            record.deactivate!
            Rails.logger.info("Record " + ("%4d"%record.id) + ", pacient " +
                              record.pacient.name + " deactivated by 5 year inactivity")
            count = count + 1
          end
        elsif (record.appointments.last.scheduled_at < 5.years.ago)
          record.deactivate!
          Rails.logger.info("Record " + ("%4d"%record.id) + ", pacient " +
                            record.pacient.name + " deactivated by 5 year inactivity")
          count = count + 1
        end
      end
    end
    puts count.to_s + " records deactivated"
  end
end