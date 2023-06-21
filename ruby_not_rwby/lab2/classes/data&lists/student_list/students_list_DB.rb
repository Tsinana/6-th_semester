require_relative '../data_list_student_short'
require_relative '../../student/student'
require_relative '../../student/student_short'
require_relative '../db_working'
require_relative 'students_list'
require 'sqlite3'

class StudentListDB < StudentList
	def initialize()
		self.db = DBWorking.new
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
	def add_student(obj_student)
		db.execute('insert into student (surname, name, patronymic, phone, telegram, email, git) VALUES (?, ?, ?, ?, ?, ?, ?)', *student_fields(obj_student))
	end
	
	# Метод. Удаляет студента указанного по id
	def delete_student(student_id)
	  db.execute('DELETE FROM student WHERE id = ?', student_id)
	end

	# Метод. Заменяет студента указанного по id
	def replace_student(obj_student, student_id)
	  db.execute('UPDATE student SET first_name=?, last_name=?, second_name=?, phone=?, telegram=?, mail=?, git=? WHERE id=?',*student_fields(obj_student), student_id)
	end

	# Метод. Возвращает количество записей 
  def student_count
    self.db.results_as_hash=false
    res = self.db.execute("Select COUNT(*) from student").first[0]
    self.db.results_as_hash=true
    res
  end
 
  private

  attr_accessor :db

	# Метод. Возвращает поля студента массивом
  def student_fields(obj_student)
    [obj_student.surname, obj_student.name,  obj_student.patronymic, obj_student.phone, obj_student.telegram, obj_student.email, obj_student.git]
  end
end

a = StudentListDB.new
