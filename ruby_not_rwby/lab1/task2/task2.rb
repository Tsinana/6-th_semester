# Метод проверки числа на простоту
def is_simple_digit(digit)
  return true if digit == 1
  return false if digit == 2
  Math.sqrt(digit).ceil.downto(2) { |i| return false if digit % i == 0 }
  true
end

# Метод нахождения максимального простого делителя числа
def max_div_with_condition(digit,condition)
  digit.step(1,-1) {|i| return i if digit % i == 0 and condition(i)}
end


# Метод нахождения максимального простого делителя числа
def max_simple_div(digit)
  digit.step(1,-1) {|i| return i if digit % i == 0 and is_simple_digit(i)}
end


# Метод нахождения произведение цифр числа, не делящихся на 5. 
def mult_numbers_not_div_5(digit)
  function = lambda { |num| num % 5 != 0 }
  mult_numbers_with_condition(digit,function)
end

# Метод нахождения произведение цифр числа c заданным условием
def mult_numbers_with_condition(digit,condition = lambda { |num| true })
  mult = 1
  digit.digits.each{|num| mult*=num if condition.call(num)}
  mult
end


puts "#{mult_numbers_div_5(1256)}"

# Оставил свой самый интересный метод
# def mult_numbers_div_5(digit)
#   mult = 1
#   digit.to_s.chars.select{|a| a.to_i % 5 != 0}.each{|b| mult*=b.to_i}
#   mult
# end 