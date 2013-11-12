class Statistics

  def self.calculate_percentages_and_labels(array)
    data = {}
    array.uniq.each do |elem|
      percentage = (array.count(elem) * 100) / array.size
      data[elem.to_s] = percentage
    end

    data
  end
end