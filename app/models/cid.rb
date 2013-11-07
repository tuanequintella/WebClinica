class Cid < ActiveRecord::Base
  require 'nokogiri'

  attr_accessible :code, :name

  has_many :record_entries
  validates_presence_of :code, :name
  validates_uniqueness_of :code

  def to_s
    txt = code + " - " + name.first(37)
    if name.size > 37
      txt = txt + ".."
    end
    txt
  end

  def self.import(file)
    begin
      doc = Nokogiri::XML(file)

      doc.css('categoria').each do |category_node|
        cid = Cid.where(code: category_node['codcat']).first_or_create(name: category_node.children.css('nome').inner_text)
        unless cid.save
          raise cid.errors.full_messages
        end

        subcategories = category_node.children.css('subcategoria')

        subcategories.each do |subcategory_node|
          cid = Cid.where(code: subcategory_node['codsubcat']).first_or_create(name: subcategory_node.children.css('nome').inner_text)

          unless cid.save
            raise cid.errors.full_messages
          end        
        end
      end
    rescue Exception => ex
      return false
    end
    return true
  end
end
