require_relative './super_student'

class StudentShort < SuperStudent
	attr_reader :id, :fullname, :git, :contact

	def initialize(id: , contact_string:)
		self.id = id
		contacts = contact_string.split("\t")
		self.fullname = contacts[0]
		self.git = contacts[1]
		self.contact = contacts[2]
	end

	#метод класса, создающий объект Student_short из Student
	def self.student_init(student_obj)
		new(id: student_obj.id, contact_string: student_obj.get_info)
	end

	private
		attr_writer :id, :fullname, :git, :contact
end