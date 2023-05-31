require_relative '../classes/student'
require_relative '../classes/students_list_JSON'

class ContextStudentList
	attr_accessor :strategy, :studentsList, :list_of_students
	def initialize(strategy)
		self.list_of_students = []
    self.strategy = strategy
  end


  def read_from_file(path)
  	raise Errno::ENOENT,"Bad path #{path}" unless File.file?(path)
  	File.open(path) do |file|
  		strategy.list_hash_from_str(file.read).each do |hash_student|
  			self.list_of_students << Student.new() 
  		end
  	end
  end


  def write_to_file(path)
  	raise Errno::ENOENT,"Bad path #{path}" unless File.file?(path)
		 File.open(path,'w') do |file|
			file.puts strategy.list_hash_to_str(list_of_students.map {&:to_hash})
		end
  end


  def get_k_n_sudent_short_list(k, n, data_list_obj = nil)
  	return data_list_obj unless data_list_obj.nil?
		DataListStudentShort.new(list_of_students.slice(n-1, k).map!{ |e| StudentShort.new(e) })
	end


	def sort_by_fullname
		 list_of_students.sort_by(&:surname)
	end

	def get_student_by_id(id)
    list_of_students.find {|student| st.id==id}
  end


	def add_student(student)
		student.id = get_new_student_id
    list_of_students << student
	end


	def replace_student_by_ID(student, student_id)
    id_student = list_of_students.find_index{|student| student.id == st_id}
    list_of_students[id_student] = student
	end

	def delete_student_by_ID(student_id)
    list_of_students.delete_if {|student| student.id == student_id}
	end


	def get_student_count
    list_of_students.size
  end
end
