# Метод проверки числа на простоту
def is_simple_digit(digit)
  return true if digit == 1
  return false if digit == 2
  Math.sqrt(digit).ceil.downto(2) { |i| return false if digit % i == 0 }
  true
end


# Метод нахождения максимального делителя числа с условием
def max_div_with_condition(digit,condition = lambda { |i| true })
  digit.step(1,-1) {|i| return i if digit % i == 0 and condition.call(i)}
end


# Метод нахождения максимального простого делителя числа
def max_simple_div(digit)
  digit.step(1,-1) {|i| return i if digit % i == 0 and is_simple_digit(i)}
end


# Метод нахождения произведение цифр числа
def mult_numbers(digit)
  digit.digits.reduce(:*)
end


# Метод нахождения произведение цифр числа c заданным условием
def mult_numbers_with_condition(digit,condition = lambda { |num| true })
  digit.digits.reduce(1){|mult,num| mult*=num if condition.call(num)}
end


# Метод нахождения произведение цифр числа, не делящихся на 5. 
def mult_numbers_not_div_5(digit)
  function = lambda { |num| num % 5 != 0 }
  mult_numbers_with_condition(digit,function)
end


#Метод вычисления НОД двух чисел
def euclidean_algorithm(digit_a,digit_b)
  return digit_b if digit_a % digit_b == 0
  return euclidean_algorithm(digit_b,digit_a % digit_b)
end


# Метод нахождения НОД максимального нечетного непростого делителя 
# числа и произведения цифр данного числа
def extraordinary_euclidean_algorithm(digit)
  odd_prime_divisor = lambda {|num| is_simple_digit(num) and num % 2 != 0}
  digit_a = max_div_with_condition(digit,odd_prime_divisor)
  digit_b = mult_numbers_with_condition(digit)
  return 0 if digit_a == 0 or digit_b ==0
  euclidean_algorithm(digit_a,digit_b)
end


# Оставил свой самый интересный метод
# def mult_numbers_div_5(digit)
#   mult = 1
#   digit.to_s.chars.select{|a| a.to_i % 5 != 0}.each{|b| mult*=b.to_i}
#   mult
# end 