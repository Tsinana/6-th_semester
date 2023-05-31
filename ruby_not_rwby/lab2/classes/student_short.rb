require_relative '../classes/super_student'

class StudentShort < SuperStudent
	attr_reader :id, :fullname, :git, :contact

	def initialize(id: , contact_string:)
		@id = id
		contacts = contact_string.split("\t")
		@fullname = contacts[0]
		@git = contacts[1]
		@contact = contacts[2]
		self.students << self
	end


	def self.student_init(student_obj)
		new(id: student_obj.id, contact_string: student_obj.get_info)
	end
end
# валидация??