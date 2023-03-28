def array_min(arr)
	min = arr[0]
  arr.each{|num|  min = num if  min> num}
  min
end


def array_first_pol(arr)
  arr.each{|num| return num if num > 0}
end


def method_selection_and_data_loading(method,data)
  return 0 if !File.exists?(data) and method != 1 and method != 2
  file_data = File.read(data).split.map(&:to_i)
  return array_min(file_data)	if method == 1
  return array_first_pol(file_data)	if method == 2
end	


puts "#{method_selection_and_data_loading(ARGV[0].to_i,ARGV[1])}"

# def array_min(arr)
#   arr.reduce(arr[0]){|min,num|  min>num ? num : min  }
# end