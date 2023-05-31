require_relative '../classes/super_student'

class Student < SuperStudent
	attr_validated :id do |val| val =~ ID_REGEX || val.nil? end
	attr_validated :surname, :name, :patronymic  do |val| val =~ FULL_NAME_REGEX || val.nil? end
	attr_validated :telegram do |val| val =~ TELEGRAM_REGEX || val.nil? end
	attr_validated :email do |val| val =~ EMAIL_REGEX || val.nil? end
	attr_validated :git do |val| val =~ GIT_REGEX || val.nil? end
	attr_validated :phone do |val| val =~ PHONE_REGEX || val.nil? end


	def initialize(id: , surname: , name: , patronymic: ,phone: nil, telegram: nil, email: nil, git: nil)
		self.id = id 
		self.surname = surname
		self.name = name 
		self.patronymic = patronymic
		self.telegram = telegram
		self.email = email 
		self.git = git
		self.phone = phone
		@@students << self
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


	def get_contact
		"#{[self.phone, self.email, self.telegram].find(&:itself)}"
	end


	def get_fullname
		"#{self.surname} #{self.name[0]} #{self.patronymic[0]}"
	end


	def get_full_git
		"https://github.com/#{self.git}"
	end


	def self.read_from_txt(path,separator = ';')
		raise Errno::ENOENT,"Bad path #{path}" unless File.file?(path)
		File.open(path) do |file|
			keys = file.first.chop.split(separator)
			file.each do |line|
				params = {}
				values = line.split(separator)
				values[-1] = values[-1].chop
				(keys.length).times do |i|
					values[i] = nil if values[i].nil? or values[i].length == 0
					params[keys[i].to_sym] = values[i]
				end
				new(**params)
			end
		end
	end


	def self.write_to_txt(path,separator = ';')
		File.open(path,'w') do |file|
			file.puts @@students[0].get_titles(separator)
			@@students.each do |student|
				file.puts student.get_data(separator)
			end
		end
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