def is_simple_digit(digit)
  return true if digit == 1
  return false if digit == 2
  Math.sqrt(digit).ceil.downto(2) { |i| return false if digit % i == 0 }
  true
end

def max_simple_div(digit)
  digit.step(1,-1) {|i| if digit % i == 0 and is_simple_digit(i) then return i end}
end

puts "#{max_simple_div(-8)}"
