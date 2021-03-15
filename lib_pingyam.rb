class Converter
  def initialize(base_rom=0)
    @dict = read_dict(base_rom)
  end 

  def convert_syllable(dict, word, method)
    w = dict[word.downcase]
    if w
      method == 11 ? w : w[method]
    else
      word
    end
  end

  def read_dict(base_rom)
    pwd = Dir.pwd
    Dir.chdir(File.dirname(__FILE__))
    file = File.open("pingyam/pingyambiu")
    Dir.chdir(pwd)
    dict = {}
    file.each do |line|
      line_split = line.chomp.split("\t")
      dict[line_split[base_rom]] = line_split
    end
    dict
  end

  def convert_line(line, method)
    line_array = line.split(/\s+/)
    result = ""
    if method == 11
      11.times do |c|
        line_array.each do |word|
          result << convert_syllable(@dict, word, c) + " "
        end
        result << "\n"
      end
    else
      line_array.each do |word|
        result << convert_syllable(@dict, word, method) + " "
      end
    end
    result.gsub(/\s+\Z/, "")
  end

  def check_syllable(word)
    w = @dict[word.downcase]
    w ? true : false
  end
end
