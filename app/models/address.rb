class Address < ContactInfo
  #attr_accessor :street, :neighborhood, :city, :state, :zipcode
  #validates_presence_of :street, :city

  #before_save :serialize_address
  #after_find :deserialize_address

  #private
  #def serialize_address
  #  self.value = [ street, neighborhood, city, state, zipcode ].map{ |field| field.gsub(';', '') }.join(';')
  #end

  #def deserialize_address
  #  street, neighborhood, city, state, zipcode = value.split(";")
  #end


end
