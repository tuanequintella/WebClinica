class Address < ContactInfo

  validates_presence_of :street, :city

  def to_s
    text = self.street + "\n"
    if(self.neighborhood)
      text += self.neighborhhod + ", "
    text += self.city
    if(self.state)
      text+= " - " + self.state
    if(self.zipcode)
      text+= "\n" + self.zipcode
  end

end
