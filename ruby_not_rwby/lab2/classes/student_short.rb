class StudentShort < SuperStudent
	attr_reader :id, :fullname, :git, :contact


	def initialize(id: , fullname: ,git: , contact:)
		@id = id
		@fullname = fullname
		@git = git
		@contact = contact
	end


	def self.student_init(student_obj)
		new(id: student_obj.id,fullname: student_obj.get_fullname, git: student_obj.git, contact: student_obj.get_contact)
	end
end
# валидация??