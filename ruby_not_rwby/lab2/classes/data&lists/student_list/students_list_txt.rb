require_relative 'students_list_file_strategy'

class StudentListTxt < StudentListFileStrategy


  def list_hash_from_str(str)
  	list_of_hash = []
  	arr_str = str.split("\n")
  	keys = arr_str.first.chop.split(';')
		(1...arr_str.length).each do |i|
			line = arr_str[i]
			params = {}
			values = line.split(';')
			values[-1] = values[-1].chop
			(keys.length).times do |i|
				values[i] = nil if values[i].nil? or values[i].length == 0
				params[keys[i].to_sym] = values[i]
			end
			list_of_hash << params
		end
		list_of_hash
  end


  def list_hash_to_str(list_hash)
  	ans_str = ''
  	keys = list_hash[0].to_s.scan(/[a-z]+|\d+/).delete_if.with_index { |_, i| not i.even? }
  	ans_str += ';'.join(keys)
  	list_hash.each do |e|
  		value = list_hash[0].to_s.scan(/[a-z]+|\d+/).delete_if.with_index { |_, i| not even? }
  		ans_str += "\n" + ';'.join(value)
  	end
  	ans_str
  end
end
