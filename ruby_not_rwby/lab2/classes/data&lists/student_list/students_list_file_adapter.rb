require_relative 'students_list_file'
require_relative 'students_list'

class StudentListFileAdapter < StudentList
	def initialize(students_list_file,path_to_data)
		self.students_list_file = students_list_file
		self.path_to_data = path_to_data
		self.students_list_file.read_from_file(path_to_data)
	end

	def get_k_n_student_short_list(elements_per_page, page_number)
		self.students_list_file.get_k_n_student_short_list(elements_per_page, page_number)
	end

	def sort_by_fullname
		self.students_list_file.sort_by_fullname
	end

	def add_student(obj_student)
		self.students_list_file.add_student(obj_student)
		self.students_list_file.write_to_file(self.path_to_data)
	end

	def replace_student_by_id(obj_student, student_id)
		self.students_list_file.replace_student_by_id(obj_student, student_id)
		self.students_list_file.write_to_file(self.path_to_data)
	end

	def delete_student_by_id(student_id)
		self.students_list_file.delete_student_by_id(student_id)
		self.students_list_file.write_to_file(self.path_to_data)
	end

	def get_student_count
		self.students_list_file.get_student_count
	end

	private
	attr_accessor :students_list_file, :path_to_data 
end