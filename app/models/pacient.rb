class Pacient < ActiveRecord::Base
  attr_accessible :name, :cpf, :rg, :birthdate, :health_insurance, :address, :phone, :email, :parent_name, :parent_rg, :parent_cpf,:health_insurance_id, :contact_infos_attributes, :record_attributes
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

  def update_metaphones
    self.name_metaphone = MetaphoneBr.metaphone_ptbr(self.name)
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
      first_results = Pacient.where("name LIKE ?", "%#{term}%")
      puts "\n\nResultados que contem o termo:\n"
      puts first_results.map(&:name).to_s

      puts "\n\nResultados similares:\n"
      term_metaphone = MetaphoneBr.metaphone_ptbr(term)
      puts "\nMetaphone do termo: " + term_metaphone

      similar_results = Pacient.all.select do |p|

        names_scores = {}
        p.name_metaphone.split(" ").each do |name|
          # calcula similaridade do primeiro nome com o termo buscado
          sw = SmithWaterman.new(name, term_metaphone)
          sw.align!
          first_rel_score = sw.score.to_f / (name.size + term_metaphone.size)
          names_scores[name] = first_rel_score
        end

        max_score = names_scores.values.max 
        if (max_score >= 0.65)
          puts "\nNome: #{p.name} => Metaphone do nome mais similar: " + names_scores.key(max_score)
          puts "Score entre " + names_scores.key(max_score) + " e " + term_metaphone + ": " + max_score.to_s
        end

        p.sw_score = max_score

        # regra do select
        (max_score >= 0.65)
      end

      # orderna por ordem decrescente de pontuação
      similar_results = similar_results.sort_by{ |p| p.sw_score }.reverse

      result = (first_results + similar_results).uniq
    else
      all.sort_by{|p| p.name}
    end
  end
  
  def as_json(options)
    options[:include] = [:health_insurance]
    super(options)
  end

end
