module StatisticsHelper
  def pick_colors(n)
    colors_array = ["FF0000", "00FFFF", "342D7E", "C0C0C0", "0000FF", "808080", " 7FFFD4", "0000A0", "ADD8E6",
                    "008080", "FFA500", "617C58", "800080", "54C571", "EDDA74", "A52A2A", "FFFF00", "800000",
                    "FFCBA4", "C19A6B", "00FF00", "008000", "493D26", "FF00FF", "E56717", "808000", "FAAFBE"]
    return colors_array.sample(n)
  end
end