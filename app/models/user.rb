#encoding: utf-8
class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation

  authenticates_with_sorcery!

  validates_presence_of :name, :username, :email
  validates_uniqueness_of :username, :email, :case_sensitive => false
  validates_uniqueness_of :rg, :crm, :allow_blank => true #, :cpf
  validates_confirmation_of :password, :if => :password
  validates :password, :presence => true, :length => {:minimum => 6}, :on => :update, :if => :password
  validates :password_confirmation, :presence => true, :on => :update, :if => :password
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  class CpfValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)

      unless value.nil?
        nulos = %w{12345678909 11111111111 22222222222 33333333333 44444444444 55555555555 66666666666 77777777777 88888888888 99999999999 00000000000}
        valor = value.scan /[0-9]/
        if valor.length == 11
          unless nulos.member?(valor.join)
            valor = valor.collect{|x| x.to_i}
            soma = 10*valor[0]+9*valor[1]+8*valor[2]+7*valor[3]+6*valor[4]+5*valor[5]+4*valor[6]+3*valor[7]+2*valor[8]
            soma = soma - (11 * (soma/11))
            resultado1 = (soma == 0 or soma == 1) ? 0 : 11 - soma
            if resultado1 == valor[9]
              soma = valor[0]*11+valor[1]*10+valor[2]*9+valor[3]*8+valor[4]*7+valor[5]*6+valor[6]*5+valor[7]*4+valor[8]*3+valor[9]*2
              soma = soma - (11 * (soma/11))
              resultado2 = (soma == 0 or soma == 1) ? 0 : 11 - soma
              if resultado2 == valor[10] # CPF válido
                return
              end
            end
          end
        end
      end

      record.errors.add attribute, (options[:message] || I18n.t("errors.messages.cpf"))

    end
  end
  
  def deactivate!
    self.active = false
  end
  
  def activate!
    self.active = true
  end

end
