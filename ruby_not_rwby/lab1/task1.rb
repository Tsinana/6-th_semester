puts 'Введите имя ползователя: '
puts ' Hello world!'

name = gets.chomp
puts "Привет #{name}\nКаков твой любимый ЯП: "
prog_lang = gets.chomp.downcase
if prog_lang == 'ruby'
  puts 'Подлиза'
elsif prog_lang == 'C'
  puts 'комментарий'
else
  puts 'Скоро будет руби'
end

puts 'Введите команду Ruby:'
command_ruby = gets.chomp
eval command_ruby

puts 'Введите команду ОС:'
command_os = gets.chomp
system command_os
