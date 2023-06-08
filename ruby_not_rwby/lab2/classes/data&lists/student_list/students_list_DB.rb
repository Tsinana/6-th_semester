require_relative 'students_list_JSON'
require 'sqlite3'

class StudentListDB
	@instance = new

	private_class_method :new

	def self.instance
		@instance
	end

	def initialize()
		self.db = SQLite3::Database.open '../../../data/students.db'
		self.db.results_as_hash = true
	end

	# Метод. Возращает k по счету n элементов формата Datalist
	def get_k_n_student_short_list(elements_per_page, page_number)
		raise "Некорректно выбран объем данных" if elements_per_page < 1 and page_number < 1
		students = db.execute('SELECT * FROM student LIMIT ? OFFSET ?',elements_per_page,elements_per_page * (page_number - 1))
	  	slice = students.map{|student| StudentShort.student_init(Student.new(**student.transform_keys(&:to_sym)))}
	  	DataListStudentShort.new(slice)
	  end

	# Метод. Возвращает студента по id
	def get_student_by_id(student_id)
	  student = db.execute('SELECT * FROM students WHERE id = ?', student_id).first
	  return nil if student.nil?
	  Student.new(**student.transform_keys(&:to_sym))
	end

	# Метод. Добавляет студента
	def add_student(student)
		db.execute('insert into student (surname, name, patronymic, phone, telegram, email, git) VALUES (?, ?, ?, ?, ?, ?, ?)', *student_fields(student))
	end

	# Метод. Удаляет студента указанного по id
	def remove_student(student_id)
	  db.execute('DELETE FROM student WHERE id = ?', student_id)
	end

	# Метод. Заменяет студента указанного по id
	def replace_student(student_id, student)
	  db.execute('UPDATE student SET first_name=?, last_name=?, second_name=?, phone=?, telegram=?, mail=?, git=? WHERE id=?',*student_fields(student), student_id)
	end

	# Метод. Возвращает количество записей 
  def student_count
    db.results_as_hash=false
    res=db.execute("Select COUNT(*) from student").first[0]
    db.results_as_hash=true
    res
  end

  private

  attr_accessor :db

	# Метод. Возвращает поля студента массивом
  def student_fields(student)
    [student.surname, student.name,  student.patronymic, student.phone, student.telegram, student.email, student.git]
  end
end