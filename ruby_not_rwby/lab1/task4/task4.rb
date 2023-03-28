# Метод проверяющий - является ли элемент по указанному индексу
# локальным минимумом
def is_index_a_local_minimum(arr,index)
	return false if index == 0 || arr.size-1 == index
	arr[index - 1] > arr[index] && arr[index] < arr[index + 1] ? true : false
end


# Метод реализующий циклический сдвиг элементов массива влево на одну позицию
def shift_array (arr)
	arr.push(arr.shift) 
end


#Метод выводящий вначале элементы с четными индексами, а затем - с нечетными
def even_index_first(arr)
	(0..arr.size-1).partition(&:even?).flatten.map{ |i| arr[i] }
end


# Метод построит два списка L1 и L2, где элементы L1  это 
# неповторяющиеся элементы исходного списка, а элемент списка L2 с номером i
# показывает, сколько раз элемент списка L1 с таким номером повторяется
# в исходном.
def create_l1_l2(arr)
	l1 = arr.uniq
	l2 = l1.map{ |i| arr.count(i) }
	[l1,l2]
end


def main()
	if File.exists?('data.txt')
		file_data = File.read('data.txt').split.map(&:to_i)
		task_names ={
		2 => shift_array(file_data),
		3 => even_index_first(file_data),
		4 => create_l1_l2(file_data),
		}
		puts "Прочитан массив из файла: #{file_data}\n\n"
		puts "Выберете метод для исполнения:\n
		1. Метод проверяющий - является ли элемент по указанному индексу локальным минимумом\n
		2. Метод реализующий циклический сдвиг элементов массива влево на одну позицию\n
		3. Метод выводящий вначале элементы с четными индексами, а затем - с нечетными\n
		4. Метод построит два списка L1 и L2, где элементы L1  это неповторяющиеся элементы исходного списка, а элемент списка L2 с номером i 
		показывает, сколько раз элемент списка L1 с таким номером повторяется в исходном.\n\n"
		task = STDIN.gets.chomp.to_i

		return 0 if !(1..4).find(task)

		if task == 1 
			puts 'Введите индекс массива: '
			index = STDIN.gets.chomp.to_i
			return 0 if index >= file_data.size - 1
			puts "\n#{is_index_a_local_minimum(file_data, index)}\n\n"
		else
			puts  task_names[task]
		end
	end
	STDIN.gets
end

puts "#{main()}"