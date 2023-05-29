class StudentListDB
	def initialize()
		db = SQLite3::Database.open 'student.db'
		db.results_as_hash = true
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
end
