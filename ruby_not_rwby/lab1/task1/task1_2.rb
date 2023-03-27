name = ARGV[0]

puts "Привет #{name}\nКаков твой любимый ЯП: "
prog_lang = STDIN.gets.chomp.downcase
if prog_lang == 'ruby'
  puts 'Подлиза'
elsif prog_lang == 'C'
  puts 'комментарий'
else
  puts 'Скоро будет руби'
end
