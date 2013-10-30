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

  before_save :update_record_status

  I18N_PATH = 'activerecord.attributes.appointment.'
  
  def update_record_status
    if status_changed? && status.finished?
      if record.status.new?
        record.status = :beginner
        record.save
      elsif record.status.inactive?
        record.status = :regular
        record.save
      elsif record.status.beginner?
        if record.appointments.with_status(:finish).size >= 3
          record.status = :regular
          record.save
        end
      end
    end
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
