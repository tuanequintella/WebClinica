class Admin < User

  I18N_PATH = 'activerecord.attributes.user.type.'

  def to_s
    I18n.t(I18N_PATH + "admin")
  end

end
