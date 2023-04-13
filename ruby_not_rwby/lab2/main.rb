require './classes/student'

begin
student = []
student << Student.new(id: '1', surname: 'lupov', name: 'lupa', patronymic: 'lupovich')
student << Student.new(id: '2', surname: 'pupov', name: 'pupa', patronymic: 'pupovich', phone_number: '+79002112332', telegram: '@pupa', email: 'pupa@mail.ru', git: 'pupaProgramer')
#Валидации же нет! Вот и всякие иванушки появляются
student << Student.new(id: '3', surname: 'Ivanov', name: 'Ivan', patronymic: 'Ivanich')
student.each{|person| puts "\n"+person.to_s(' ') }

puts "\n"
student[1].set_contacts(telegram: '@asdfgh')
student.each{|person| puts "\n"+person.to_s(' ') }

rescue StandardError => e
	puts "Error: #{e.message}"
	
end