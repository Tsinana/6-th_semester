require_relative 'students_view'
require_relative './data&lists/student_list/students_list'
# require_relative './data&lists/student_list/students_list_db'

class StudentsListControler
	
	def initialize(student_list_with_strategy)
		self.students_list = student_list_with_strategy
	end
 
	def refresh_data
		self.data_list = self.students_list.get_k_n_student_short_list(1,3)
	end

	def set_view(view)
		self.view = view
	end

	def get_data_list
		self.data_list
	end

	private
	attr_accessor :data_list, :students_list, :view
end

