class Student
	attr_accessor :id, :surname, :name, :patronymic, :phone_number, :telegram, :email, :git

	def initialize(id: , surname: , name: , patronymic: ,phone_number: nil, telegram: nil, email: nil, git: nil)
		@id, @surname, @name, @patronymic, @phone_number, @telegram, @email, @git = id, surname, name, patronymic, phone_number, telegram, email, git
	end

	def to_s
		"id:#{@id};surname:#{@surname};name:#{@name};patronymic:#{@patronymic};phone_number:#{@phone_number};telegram:#{@telegram};email:#{@email};git: #{@git};"
	end
end