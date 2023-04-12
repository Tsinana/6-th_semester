require './classes/Student'

student = []
student << Student.new(id: 1, surname: 'lupov', name: 'lupa', patronymic: 'lupovich')
student << Student.new(id: 2, surname: 'pupov', name: 'pupa', patronymic: 'pupovich', phone_number: '+79002112332', telegram: '@pupa', email: 'pupa@mail.ru', git: 'pupaProgramer')
#Валидации же нет! Вот и всякие иванушки появляются
student << Student.new(id: 1, surname: 'Ivanov', name: 'Ivan', patronymic: 'Ivanich', phone_number: 'sony', telegram: 'ul. Pushkina', email: 'ivan_boitsia_@s')

student.each{|person| puts "\n"+person.to_s }
