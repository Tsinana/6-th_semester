require_relative '../../student/student'
require_relative '../data_list_student_short'

class ContextStudentList
	def initialize(strategy)
		self.list_of_students = []
    self.strategy = strategy
  end

	# Метод. Установка новой стратегии
  def set_strategy(strategy)
  	self.strategy = strategy
  end

	# Метод. Чтение из файла
  def read_from_file(path)
  	raise Errno::ENOENT,"Bad path #{path}" unless File.file?(path)
  	File.open(path) do |file|
  		strategy.list_hash_from_str(file.read).each do |hash_student|
  			self.list_of_students << Student.new() 
  		end
  	end
  end

	# Метод. Запись на файл
  def write_to_file(path)
  	raise Errno::ENOENT,"Bad path #{path}" unless File.file?(path)
		File.open(path,'w') do |file|
		file.puts strategy.list_hash_to_str(list_of_students.map &:to_hash)
		end
  end

	# Метод. Возращает k по счету n элементов формата Datalist
  def get_k_n_sudent_short_list(k, n, data_list_obj = nil)
  	return data_list_obj unless data_list_obj.nil?
		DataListStudentShort.new(list_of_students.slice((k-1) * n, n).map!{ |e| StudentShort.new(e) })
	end

	# Метод. Сортирует по полному имени  
	def sort_by_fullname
		 list_of_students.sort_by(&:surname)
	end

	# Метод. Возвращает студента по id
	def get_student_by_id(id)
    list_of_students.find {|student| st.id==id}
  end

	# Метод. Добавляет студента
	def add_student(student)
		student.id = get_new_student_id
    list_of_students << student
	end

	# Метод. Заменяет студента указанного по id
	def replace_student_by_ID(student, student_id)
    id_student = list_of_students.find_index{|student| student.id == st_id}
    list_of_students[id_student] = student
	end

	# Метод. Удаляет студента указанного по id
	def delete_student_by_ID(student_id)
    list_of_students.delete_if {|student| student.id == student_id}
	end

	# Метод. Возвращает количество записей 
	def get_student_count
    list_of_students.size
  end

	private
  	attr_accessor :strategy, :list_of_students
end
