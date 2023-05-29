require_relative './classes/data_table'




begin

# Student.read_from_txt('./data/data_file.txt')

# students = Student.get_students
# students.each do |student|
# 	StudentShort.student_init student
# end	

# student_sh = StudentShort.student_init students[1]
# puts student_sh.to_s
# puts students[1].get_info


table_data = [
  ['id', 'Name', 'Age', 'Gender'],
  [1, 'John', 25, 'Male'],
  [2, 'Jane', 30, 'Female'],
  [3, 'Bob', 45, 'Male']
]

table = DataTable.new(table_data)

puts table.get_cell(2, 1) # Выводит "30"
puts table.num_columns # Выводит "3"
puts table.num_rows # Выводит "4"



# table_list = ['O1','O2','O3','O4','O5']
# list = DataList.new(table_list)

# list.select(4)
# list.select(1)
# list.select(0)

# puts list.get_selected.to_s

# rescue StandardError => e
# 	puts "Error: #{e.message}"
	
end