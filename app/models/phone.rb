class Phone < ContactInfo

  #validate :value, :format => {:with => /(?:(?([0-9]{2}))?[-. ]?)?([0-9]{4})[-. ]?([0-9]{4})/}

end
