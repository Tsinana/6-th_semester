require './classes/MyErrors'
require './modules/AttrValidated'

class Student
	include AttrValidated 

	ID_regex = /^[0-9]+$/
	Phone_number_regex = /^[(\+7)8][0-9]+$/
	Full_name_regex = /^[\w]+$/
	Telegram_regex = /^@[\w0-9]+$/
	Git_regex = /^[\w0-9]+$/
	Email_regex = /^[\w\-\.]+@([\w-]+\.)+[\w-]{2,4}$/

	attr_validated (:id) {|val| val =~ ID_regex || val.nil?}
	attr_validated :surname, :name, :patronymic  do |val| val =~ Full_name_regex || val.nil? end
	attr_validated (:telegram) {|val| val =~ Telegram_regex || val.nil?} 
	attr_validated (:email) {|val| val =~ Email_regex || val.nil?} 
	attr_validated (:git) {|val| val =~ Git_regex || val.nil?} 
	attr_validated (:phone_number) {|val| val =~ Phone_number_regex || val.nil?} 

	def initialize(id: , surname: , name: , patronymic: ,phone_number: nil, telegram: nil, email: nil, git: nil)
		self.id = id 
		self.surname = surname
		self.name = name 
		self.patronymic = patronymic
		self.telegram = telegram
		self.email = email 
		self.git = git
		self.phone_number = phone_number
	end


	# функция преобразования объекта в строку с разделителем арг: -separator 
	def to_s(separator = ';')
		"#{@id}#{separator}#{@surname}#{separator}#{@name}#{separator}#{@patronymic}#{separator}#{@phone_number}#{separator}#{@telegram}#{separator}#{@email}#{separator}#{@git}#{separator}"
	end


	# функция вывода титулов объекта в строку с разделителем арг: -separator
	def print_title(separator = ';')
		"id#{separator}surnamename#{separator}patronymic#{separator}phone_number#{separator}telegram#{separator}email#{separator}git#{separator}"
	end
end