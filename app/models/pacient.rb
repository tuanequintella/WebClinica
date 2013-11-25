class Pacient < ActiveRecord::Base
  attr_accessible :first_name, :surname, :cpf, :rg, :birthdate, :health_insurance, :address, :phone, :email, :parent_name, :parent_rg, :parent_cpf,:health_insurance_id, :contact_infos_attributes, :record_attributes
  attr_accessor :contact_infos_attributes, :record_attributes, :sw_score

  validates_presence_of :name, :email, :address, :phone, :birthdate, :health_insurance
  validates :rg, :cpf, :presence => { :if => :overage? }
  validates :parent_name, :parent_rg, :parent_cpf, :presence => { :unless => :overage? }
  
  before_save :update_metaphones

  belongs_to :health_insurance
  has_many :contact_infos, :as => :reachable
  has_one :record

  accepts_nested_attributes_for :record, :contact_infos, :allow_destroy => true

  def to_s
    self.name
  end

  def name
    [first_name, surname].join(" ")
  end

  def update_metaphones
    self.first_name_metaphone = MetaphoneBr.metaphone_ptbr(first_name)
    self.surname_metaphone = MetaphoneBr.metaphone_ptbr(surname)
  end

  def overage?
    my_age = self.age
    if my_age[:years] >=18
      true
    else
      false
    end
  end

  def active?
    record.active?
  end

  def self.records_list
    list = []
    Pacient.all.each do |p|
      list << [p.name, p.record.id]
    end
    list
  end

  def age
    return {:years => 0, :months => 0} if birthdate.nil?
    years = Date.today.year - birthdate.year
    months = Date.today.month - birthdate.month
    if Date.today.month < birthdate.month || (Date.today.month == birthdate.month && birthdate.day >= Date.today.day)
      years  = years  - 1
      months = months + 12
      if birthdate.day >= Date.today.day
        months = months - 1
      end
    end
    {:years => years, :months => months}
  end

  def age_in_words
    my_age = self.age
    I18n.t('datetime.distance_in_words.x_years', :count => my_age[:years] ) + " " + I18n.t('datetime.distance_in_words.x_months', :count => my_age[:months] )
  end

  def age_in_years
    idade = age[:years]
    if idade == 1
      idade.to_s + " ano"
    elsif idade < 1
      "Menos de 1 ano"
    else
      idade.to_s + " anos"
    end
  end

  def self.params_search(params)
    entries = RecordEntry.includes(appointment: [:record]).where(cid_id: params[:cid_id]).all
    records = entries.map(&:appointment).map(&:record)

    start_date = (Date.today - params[:age_from].to_i.years) rescue Date.today
    end_date = (Date.today - params[:age_to].to_i.years) rescue Date.today
    pacients = Pacient.where('birthdate <= ? AND birthdate >= ?', start_date, end_date).all

    records = records.select{|rec| rec.pacient.in? pacients}
    result = records.map(&:pacient).uniq
  end

  def self.quick_search (term)
    if term.present?
      puts "\n\nTERMO: #{term}" 
      first_results = Pacient.where("first_name LIKE ? OR surname LIKE ?", "%#{term}%", "%#{term}%")
      puts "\n\nResultados que contem o termo:\n"
      puts first_results.map(&:name).to_s

      puts "\n\nResultados similares:\n"
      term_metaphone = MetaphoneBr.metaphone_ptbr(term)
      puts "\nMetaphone do termo: " + term_metaphone

      similar_results = Pacient.all.select do |p|

        # calcula similaridade do primeiro nome com o termo buscado
        sw = SmithWaterman.new(p.first_name_metaphone, term_metaphone)
        sw.align!
        first_rel_score = sw.score.to_f / (p.first_name_metaphone.size + term_metaphone.size)
        
        if (first_rel_score >= 0.65)
          puts "\nPrimeiro nome: #{p.first_name} => Metaphone: #{p.first_name_metaphone}"
          puts "\nScore entre " + p.first_name_metaphone + " e " + term_metaphone + ": " + first_rel_score.to_s
        end

        # calcula similaridade do último nome com o termo buscado
        last_name = p.surname.split(" ").last
        last_name_metaphone = p.surname_metaphone.split(" ").last
        sw = SmithWaterman.new(last_name_metaphone, term_metaphone)
        sw.align!
        last_rel_score = sw.score.to_f / (last_name_metaphone.size + term_metaphone.size)
        
        if (last_rel_score >= 0.65)
          puts "\nUltimo nome: #{last_name} => Metaphone: #{last_name_metaphone}"
          puts "\nScore entre " + last_name_metaphone + " e " + term_metaphone + ": " + last_rel_score.to_s
        end

        p.sw_score = [first_rel_score, last_rel_score].max

        # regra do select
        (first_rel_score >= 0.65 || last_rel_score >= 0.65)
      end

      # orderna por ordem decrescente de pontuação
      similar_results = similar_results.sort_by{ |p| p.sw_score }.reverse

      result = (first_results + similar_results).uniq
    else
      all
    end
  end
  
  def as_json(options)
    options[:include] = [:health_insurance]
    super(options)
  end

end
