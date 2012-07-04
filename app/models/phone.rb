class Phone < ContactInfo

  validates :value, :format => {:with => "(?:(?([0-9]{2}))?[-. ]?)?([0-9]{4})[-. ]?([0-9]{4})"}

  def to_s
    self.value
  end

end
