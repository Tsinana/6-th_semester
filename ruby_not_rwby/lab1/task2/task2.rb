def is_simple_digit(digit)
  return true if digit == 1
  return false if digit == 2
  Math.sqrt(digit).ceil.downto(2) { |i| return false if digit % i == 0 }
  true
end


def max_simple_div(digit)
  digit.step(1,-1) {|i| return i if digit % i == 0 and is_simple_digit(i)}
end


# def mult_numbers_div_5(digit)
#   mult = 1
#   digit.to_s.chars.select{|a| a.to_i % 5 != 0}.each{|b| mult*=b.to_i}
#   mult
# end 


def mult_numbers_div_5(digit)
  mult = 1
  digit.digits.each{|a| mult*=a if a % 5 != 0 }
  mult
end


puts "#{max_simple_div(10)}"
puts "#{mult_numbers_div_5(1256)}"

