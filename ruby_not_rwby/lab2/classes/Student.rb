require './classes/MyErrors'

class Student
	attr_accessor :id, :surname, :name, :patronymic, :phone_number, :telegram, :email, :git

	def initialize(id: , surname: , name: , patronymic: ,phone_number: nil, telegram: nil, email: nil, git: nil)
		raise UncorrectPhoneError , "id: #{id} phone_number: #{phone_number}" if !phone_number.nil? && !Student::phone_number_validation?(phone_number)

		@id = id 
		@surname = surname
		@name = name 
		@patronymic = patronymic
		@telegram = telegram
		@email = email 
		@git = git
		@phone_number = phone_number
	end

	# title:value; ; - separator
	def to_s
		"id:#{@id};surname:#{@surname};name:#{@name};patronymic:#{@patronymic};phone_number:#{@phone_number};telegram:#{@telegram};email:#{@email};git:#{@git};"
	end

	def self.phone_number_validation?(phone_number)
		phone_number =~ /^[(\+7)8][0-9]{11}$/
	end
end