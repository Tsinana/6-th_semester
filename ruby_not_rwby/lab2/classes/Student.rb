require './classes/my_errors'
require './modules/attr_validated'

class Student
	require 'json'
	include AttrValidated 


	ID_regex = /^[0-9]+$/
	Phone_regex = /^[(\+7)8][0-9]+$/
	Full_name_regex = /^[\w]+$/
	Telegram_regex = /^@[\w0-9]+$/
	Git_regex = /^[\w0-9]+$/
	Email_regex = /^[\w\-\.]+@([\w-]+\.)+[\w-]{2,4}$/

	attr_writer :vk
	attr_validated :id do |val| val =~ ID_regex || val.nil? end
	attr_validated :surname, :name, :patronymic  do |val| val =~ Full_name_regex || val.nil? end
	attr_validated :telegram do |val| val =~ Telegram_regex || val.nil? end
	attr_validated :email do |val| val =~ Email_regex || val.nil? end
	attr_validated :git do |val| val =~ Git_regex || val.nil? end
	attr_validated :phone do |val| val =~ Phone_regex || val.nil? end


	def initialize(id: , surname: , name: , patronymic: ,phone: nil, telegram: nil, email: nil, git: nil,vk: nil)
		self.id = id 
		self.surname = surname
		self.name = name 
		self.patronymic = patronymic
		self.telegram = telegram
		self.email = email 
		self.git = git
		self.phone = phone
		self.vk = 1
	end


	# метод формирует массив "поле: значение" которые разрешенны к выводу
	def get_permit_data
		fields = []
    self.instance_variables.each do |var|
      name = var.to_s.delete("@")
      if self.respond_to?(name)
        value = self.send(name)
        fields << "#{name}: #{value}" # важный пробел
      end
  	end
  	fields
	end

	# метод преобразования объекта в строку
	def to_s
		get_permit_data.join(", ")
	end


	# метод вывода титулов объекта в строку с разделителем арг: -separator
	def get_titles(separator = ';')
		get_permit_data.map{|val| val.split(":").first}.join("#{separator}")
	end


	# метод преобразования данных объекта в строку с разделителем арг: -separator 
	def get_data(separator = ";")
		get_permit_data.map{|val| val.split(":").last.strip}.join("#{separator}")
	end


	# метод преобразования строки в объект. Строка формата to_s
	def self.string_to_obj(str)
	  hash = {}
	  str.split(", ").each do |field|
			name, value = field.split(": ")
			hash[name.to_sym] = value
	  end
	  self.new(**hash)
	end


	# метод, который устанавливает значения поля или полей для введенных контактов.
	def set_contacts(email: self.email, phone: self.phone, telegram: self.telegram)
		self.email = email
		self.phoneva = phone
		self.telegram = telegram
	end

	def get_info
		self.validate
		person = "#{self.surname} #{self.name[0]} #{self.patronymic[0]}"
		person += "\t#{@vk}"
		person += "\t#{[self.phone, self.email, self.telegram].find(&:itself)}"
	end


	def get_git
		"https://github.com/#{self.git}"
	end

	private
	
	# метод, который проводит две валидации наличие гита и наличие любого контакта для связи
	def validate
		validate_git
		validate_contact_info
	end

	def validate_git
		raise "Git не установлен" if :git == nil
	end

	def validate_contact_info
		contact_info = [:phone, :email, :telegram]
		raise "Нет контактной информации" unless contact_info.any? { |info| !send(info).nil? }
	end
end