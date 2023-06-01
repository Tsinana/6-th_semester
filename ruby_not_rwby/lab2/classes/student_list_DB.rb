require_relative '../classes/students_list_JSON'
require_relative '../modules/my_singleton'
require 'sqlite3'

class StudentListDB
	extend MySingleton


	def initialize()
		self.db = SQLite3::Database.open 'student.db'
		self.db.results_as_hash = true
	end


	def get_student_by_id(student_id)
		db.query("SELECT * FROM student WHERE id = ?", student_id).first
	end


	def get_k_n_student_short_list(elements_per_page, page_number)
		raise "Некорректно выбран объем данных" if elements_per_page < 1 and page_number < 1
		students = db.execute('SELECT * FROM student LIMIT ? OFFSET ?',elements_per_page,elements_per_page*(page_number-1))
	  	slice = students.map{|student| StudentShort.student_init(Student.new(**student.transform_keys(&:to_sym)))}
	  	DataListStudentShort.new(slice)
	  end


	def get_student_by_id(student_id)
	  student = db.execute('SELECT * FROM students WHERE id = ?', student_id).first
	  return nil if student.nil?
	  Student.new(**student.transform_keys(&:to_sym))
	end


	def add_student(student)
		db.execute('insert into student (surname, name, patronymic, phone, telegram, email, git) VALUES (?, ?, ?, ?, ?, ?, ?)', *student_fields(student))
	end


	#удаление студента по id
	def remove_student(student_id)
	  db.execute('DELETE FROM student WHERE id = ?', student_id)
	end

	#замена студента по id
	def replace_student(student_id, student)
	  db.execute('UPDATE student SET first_name=?, last_name=?, second_name=?, phone=?, telegram=?, mail=?, git=? WHERE id=?',*student_fields(student), student_id)
	end

 #подсчет количества студентов
  def student_count
    db.results_as_hash=false
    res=db.execute("Select COUNT(*) from student").first[0]
    db.results_as_hash=true
    res
  end

  private

  attr_accessor :db

  def student_fields(student)
    [student.surname, student.name,  student.patronymic, student.phone, student.telegram, student.email, student.git]
  end
end

a = StudentListDB.new

a1 = StudentListDB.new


puts StudentListDB.cat