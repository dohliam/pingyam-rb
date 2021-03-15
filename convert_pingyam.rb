#!/usr/bin/ruby

require_relative 'lib_pingyam.rb'

conv = Converter.new

pingyam = ARGV[0]

if !pingyam
  abort("Please enter some romanized Cantonese text to convert.")
end

romsys = ARGV[1]

if !romsys
  romsys = 1
else
  romsys = romsys.to_i
end

puts conv.convert_line(pingyam, romsys)
