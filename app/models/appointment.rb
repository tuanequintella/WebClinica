#encoding: utf-8
class Appointment < ActiveRecord::Base
  extend Enumerize

  attr_accessible :record, :agenda, :scheduled_at, :agenda_id, :record_id, :health_insurance_id, :status
  
  belongs_to :record
  belongs_to :agenda
  belongs_to :health_insurance

  validates_presence_of :record_id, :health_insurance_id, :agenda, :scheduled_at, :status
  enumerize :status, in: [:pending, :pacient_arrived, :on_going, :finished, :pacient_absent], default: :pending, scope: true

  has_one :record_entry

  before_destroy :check_destroyable
  before_save :update_record_status

  I18N_PATH = 'activerecord.attributes.appointment.'
  
  def check_destroyable
    if record_entry.present? || scheduled_at < Time.now
      return false
    end
    true
  end

  def update_record_status
    if status_changed? && status.finished?
      if record.status.new?
        record.status = :regular
        record.save
      elsif record.status.inactive?
        record.status = :regular
        record.save
      elsif record.status.beginner?
        apps = record.appointments.select{ |ap| ap.status.finished? }
        if apps.size >= 4
          record.status = :regular
          record.save
        end
      end
    end
  end

  def time_only
    self.scheduled_at.change(day: 1, month: 1, year: 2000)
  end

  def self.past_status_values
    ["finished","pacient_absent"]
  end

  def localized_date
    I18n.l(scheduled_at.to_date)
  end

  def to_s
    I18n.l(self.scheduled_at)
  end

  def as_json (options = {})
    super(options.merge!(methods: [:localized_date]))
  end

end
