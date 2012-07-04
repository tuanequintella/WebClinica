class Email < ContactInfo

  validates :value, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  def to_s
    self.value
  end

end
