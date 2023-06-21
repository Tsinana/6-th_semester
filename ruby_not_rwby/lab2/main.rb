# require_relative './classes/student'
# require_relative './classes/student_short'
# require_relative './classes/data_list_student_short'

begin

  a = Hash["a", 100, "b", 200].to_s
  b = a.scan(/[a-z]+|\d+/).delete_if.with_index { |_, i| not i.even? }
  arr = [1,1,1,1,2,2,2,2]
  counts = arr.group_by(&:itself).map { |k, v| [v.count] if v.count != 4}.compact
  puts counts.to_s


  # student_sh = students
  # puts students.to_s

  # table_data = [
  #   [1, 'John', 25, 'Male'],
  #   [2, 'Jane', 30, 'Female'],
  #   [3, 'Bob', 45, 'Male']
  # ]

  # table = DataListStudentShort.new(table_data)
  # puts table.get_data.inspect


  # table_list = ['O1','O2','O3','O4','O5']
  # list = DataList.new(table_list)

  # list.select(4)
  # list.select(1)
  # list.select(0)

  # puts list.get_selected.to_s

  # rescue StandardError => e
  # 	puts "Error: #{e.message}"
	
end