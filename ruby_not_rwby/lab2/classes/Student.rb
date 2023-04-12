require './classes/MyErrors'

class Student
	attr_accessor :id, :surname, :name, :patronymic, :telegram, :email, :git
	attr_reader :phone_number
	def initialize(id: , surname: , name: , patronymic: ,phone_number: nil, telegram: nil, email: nil, git: nil)
		puts Student::phone_number_check(phone_number,id)
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

	def phone_number=(val)
		@phone_number = val
	end

	def set_phone_number(val)
		@phone_number = val
	end

	def self.phone_number_check(phone_number, id = nil)
		raise UncorrectPhoneError , "id: #{id} phone_number: #{phone_number}" if !phone_number.nil? && !Student::phone_number_validation?(phone_number)
		true
	end

	# Проверка номера 
	def self.phone_number_validation?(phone_number)
		phone_number =~ /^[(\+7)8][0-9]{11}$/
	end
end