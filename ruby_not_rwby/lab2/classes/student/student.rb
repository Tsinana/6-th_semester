require_relative './super_student'

class Student < SuperStudent
	attr_validated :id do |val| self.validate_id val end
	attr_validated :surname, :name, :patronymic  do |val| self.validate_full_name val end
	attr_validated :telegram do |val| self.validate_telegram val end
	attr_validated :email do |val| self.validate_email val end
	attr_validated :git do |val| self.validate_git val end
	attr_validated :phone do |val| self.validate_phone val end


	def initialize(id:, surname:, name:, patronymic:, phone: nil, telegram: nil, email: nil, git: nil)
		self.id = id 
		self.surname = surname
		self.name = name 
		self.patronymic = patronymic
		self.telegram = telegram
		self.email = email 
		self.git = git
		self.phone = phone
	end

	# метод, который устанавливает значения поля или полей для введенных контактов.
	def set_contacts(email: self.email, phone: self.phone, telegram: self.telegram)
		self.email = email
		self.phoneva = phone
		self.telegram = telegram
	end

	# метод, который возвращает краткую информацию о студенте – Фамилия и Инициалы; гит, связь в ОДНОЙ строке
	def get_info
		self.validate
		person = "#{self.get_fullname}"
		person += "\t#{self.get_full_git}"
		person += "\t#{self.get_contact}"
	end

	# метод, который возвращает любой существующий один контакт
	def get_contact
		"#{[self.phone, self.email, self.telegram].find(&:itself)}"
	end

	# метод, который возвращает полное имя студента вормата Фамилия И О
	def get_fullname
		"#{self.surname} #{self.name[0]} #{self.patronymic[0]}"
	end

	# метод, который возвращает ссылку на гит студента
	def get_full_git
		"https://github.com/#{self.git}"
	end

	def self.validate_id val
		val.to_s =~ ID_REGEX || val.nil?
	end

	def self.validate_full_name val
		val =~ FULL_NAME_REGEX || val.nil?
	end

	def self.validate_telegram val
		val =~ TELEGRAM_REGEX || val.nil?
	end

	def self.validate_email val
		val =~ EMAIL_REGEX || val.nil?
	end

	def self.validate_git val
		val =~ GIT_REGEX || val.nil?
	end

	def self.validate_phone val
		val =~ PHONE_REGEX || val.nil?
	end

	private

	# метод, который проводит две валидации: наличие гита и наличие любого контакта для связи
	def validate
		validate_git
		validate_contact_info
	end

	# метод, который проводит валидацию на гит
	def validate_git
		raise "Git не установлен" if :git == nil
	end

# метод, который проводит валидацию на контакты студента
	def validate_contact_info
		contact_info = [:phone, :email, :telegram]
		raise "Нет контактной информации" unless contact_info.any? { |info| !send(info).nil? }
	end
end