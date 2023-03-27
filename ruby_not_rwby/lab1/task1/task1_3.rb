puts 'Введите команду Ruby:'
command_ruby = STDIN.gets.chomp
eval command_ruby

puts 'Введите команду ОС:'
command_os = STDIN.gets.chomp
system command_os
