class SuperStudent
	include AttrValidated 


	ID_REGEX = /^[0-9]+$/
	PHONE_REGEX = /^[(\+7)8][0-9]+$/
	FULL_NAME_REGEX = /^[\w]+$/
	TELEGRAM_REGEX = /^@[\w0-9]+$/
	GIT_REGEX = /^[\w0-9]+$/
	EMAIL_REGEX = /^[\w\-\.]+@([\w-]+\.)+[\w-]{2,4}$/


	# метод формирует массив "поле: значение" которые разрешенны к выводу
	def get_permit_data
		fields = []
    self.instance_variables.each do |var|
      key = var.to_s.delete("@")
      if self.respond_to?(key)
        value = self.send(key)
        fields << "#{key}: #{value}" # важный пробел
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
	  params = {}
		str.split(',').each do |field|
    	key, value = field.split(':').map(&:strip)
	    raise "Unknown field: #{key}" unless defined?("@#{key}")
	    value = nil if value.length == 0
	    params[key.to_sym] = value
 		end
	  self.new(**params)
	end
end