require_relative "modal_win_add_student"
require_relative "./student/student"
require_relative './data&lists/student_list/students_list'
require_relative './data&lists/student_list/students_list_db'
require 'sqlite3'

class ControllerAddStudent
	def initialize
		self.students_class = Student
	end

	def add_student(hash_student)
		hash_student.transform_values! { |value| value == "" ? nil : value }
		self.main_controller.add_student(Student.new(**(hash_student.to_hash.transform_keys(&:to_sym))))
	end

	def set_view(view)
		self.view = view
	end

	def set_main_controller(main_controller)
		self.main_controller = main_controller
	end

	private

	attr_accessor :students_class, :view, :main_controller
end

