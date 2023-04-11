class Student
	attr_accessor :id, :surname, :name, :patronymic, :phone, :telegram, :mail, :git

	def initialize(id: , surname: , name: , patronymic: ,phone: nil, telegram: nil, mail: nil, git: nil)
		@id, @surname, @name, @patronymic, @phone, @telegram, @mail, @git = id, surname, name, patronymic, phone, telegram, mail, git
	end
end

Student.new(id: 465132,surname: 'surname',name: 'name',patronymic: 'patronymic')