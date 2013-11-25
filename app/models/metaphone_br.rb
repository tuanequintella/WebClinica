#encoding: utf-8
class MetaphoneBr
  class Rules # :nodoc:all

    # Metaphone rules.  These are simply applied in order.
    #
    v = 'AEIOU'
    c = 'BCDFGHJKLMNPQRSTVWXYZ'

    PTBR_STANDARD = [
      # Regexp, replacement
      [ /Ç/, 'SS'],
      [ /Y/, 'I' ],                # ja tratado por $itr, portanto vem antes das demais
      [ /([BCDFGHJKLMNPQTVWXYZ])\1+/, '\1' ],  # Remove consoantes duplicadas exceto R e S
      [ /^([#{v}])/, '\1' ],        # ou seja, copia a vogal
      [ /B/, 'B' ],
      [ /CT/, 'T' ],
      [ /C[AOU]/, 'K', ],
      [ /CHR/, 'K' ],
      [ /CH/, 'X' ],
      [ /C[EI]/, 'S' ],
      [ /C[#{c}]/, 'K' ],          # regra mais genérica aplica-se por último
      [ /([#{v}])U/, '\1L' ],      # new 2011-11, introduz L, vogal qq preservada
      [ /C$/, 'K' ],               # new 2011-11
      [ /TR/, 'TR' ],              # new 2011-11
      [ /T[#{v}]/, 'T' ],          # new 2011-11
      [ /TH[#{v}]/, 'T' ],
      [ /D/, 'D' ],
      [ /F/, 'F' ],
      [ /G[AOU]/, 'G' ],
      [ /G[EI]/, 'J' ],
      [ /GH[EI]/, 'J' ],
      [ /GH[#{c}]/, 'G' ],
      [ /^H([#{v}])/, '\1' ],
      [ /H/, '' ],                  # Outros casos de aparição de H devem ser ignorados
      [ /J/, 'J' ],
      [ /K/, 'K' ],
      [ /LH/, '1' ],               # não tem representacao no metaphone original
      [ /^L/, 'L' ],
      [ /L[#{v}]/, 'L' ],
      [ /M/, 'N' ],               #M tem som parecido com N
      [ /N$/, 'N' ],
      [ /NH/, '3' ],                # não tem representação no metaphone original
      [ /P/, 'P' ],
      [ /PH/, 'F' ],
      [ /Q/, 'K' ],
      [ /^R/, '2' ],                # não tem representação no metaphone original
      [ /R$/, '2' ],                 # não tem representação no metaphone original
      [ /RR/, '2' ],
      [ /[#{v}]R[#{v}]/, 'R' ],
      [ /.R[#{c}]/, 'R' ],
      [ /SS/, 'S' ],
      [ /SH/, 'X' ],
      [ /SC[EI]/, 'S' ],
      [ /SC[AUO]/, 'SK' ],         # sim - duas letras porque tem sons distintos quando acompanhadas de U ou O.
      [ /SCH/, 'X' ],
      [ /S[#{c}]/, 'S' ],
      [ /S[#{v}]/, 'S' ], 
      [ /S/, 'S' ],                # caso as outras regras não se apliquem, esta entra em vigor
      [ /T/, 'T' ],
      [ /TH/, 'T' ],
      [ /V/, 'V' ],
      [ /W[#{v}]/, 'V' ],
      [ /W[#{c}]/, '' ],
      [ /X$/, 'X' ],               # o mais adequado seria KS...
      [ /^EX[#{v}]/, 'Z' ], 
      [ /.EX[EI]/, 'X' ], 
      [ /.EX[AOU]/, 'X' ],
      [ /EX[EI]/, 'X' ], 
      [ /EX[AOU]/, 'KS' ],
      [ /EX[PTC]/,'S' ],
      [ /EX./, 'KS' ],
      [ /[#{v}CKGLRX][AIOU]X/, 'X' ],
      [ /[DFMNPQSTVZ][AIOU]X/, 'KS' ],
      [ /X/, 'X' ],                # caso nenhuma caso acima case com a palavra, aplica-se esta regra
      [ /Z$/, 'S' ],
      [ /Z/, 'Z' ]
    ]

  end

  # Returns the Metaphone representation of a string. If the string contains
  # multiple words, each word in turn is converted into its Metaphone
  # representation. Note that only the letters A-Z are supported, so any
  # language-specific processing should be done beforehand.
  #
  #
  def self.metaphone_ptbr(str)
    normalized_str = str.gsub('ç','ss') #unica letra acentuada que o som certo é trocar por outra letra

    # substitui os caracteres acentuados por caracteres normais sem acento
    normalized_str = normalized_str.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/,'').to_s

    return normalized_str.strip.split(/\s+/).map { |w| MetaphoneBr.metaphone_word_ptbr(w) }.join(' ')
  end

  def self.metaphone_word_ptbr(w)
    # Normalise case and remove non-ASCII
    s = w.upcase.gsub(/[^A-Z]/, '')

    # Apply the Metaphone rules
    rules = Rules::PTBR_STANDARD
    rules.each do |rx, rep|
      s.gsub!(rx, rep)
    end
    return s.upcase
  end

end