class Cid < ActiveRecord::Base
  attr_accessible :code, :name

  has_many :record_entries
  validates_presence_of :code, :name

  def to_s
    txt = code + " - " + name.first(37)
    if name.size > 37
      txt = txt + ".."
    end
    txt
  end
end
