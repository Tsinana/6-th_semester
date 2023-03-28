def array_min(arr)
  arr.reduce(arr[0]){|min,num|  min>num ? num : min  }
end


def array_first_pol(arr)
  arr.each{|num| return num if num > 0}
end


def task2(method,file)
  return 0 if !File.exists?(file) and method != 1 and method != 2
  file_data = File.read(file).split.map(&:to_i)
  return array_min(file_data)	if method == 1
  return array_first_pol(file_data)	if method == 2
end	


puts "#{task2(2,'data.txt')}"