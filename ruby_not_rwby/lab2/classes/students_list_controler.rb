require_relative 'students_view'
require_relative './data&lists/student_list/students_list'
require 'sqlite3'

class StudentsListControler
	
	def initialize
		self.students_list = StudentListDB.new()
		rescue SQLite3::CantOpenException  => e
			self.connect_to_json
	end
 
	def refresh_data
		self.model.set_data(self.students_list.get_k_n_student_short_list(1,3).get_list_objs)
		rescue SQLite3::CantOpenException  => e
			self.connect_to_json
			self.model.set_data(self.students_list.get_k_n_student_short_list(1,3).get_list_objs)
		ensure
			get_model.notify
	end

	def set_view(view)
		self.view = view
	end

	def set_model(model)
		self.model = model
	end

	def get_model
		self.model
	end

	private

	def connect_to_json
		students_list_file = StudentListFile.new(StudentListJson.new())
    	model = StudentListFileAdapter.new(students_list_file,"C:\\Users\\Tsinana\\GitHub\\6-th_semester\\ruby_not_rwby\\lab2\\data\\data_file.json")
		self.students_list = model
	end

	attr_accessor :model, :students_list, :view
end

