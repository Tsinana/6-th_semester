# Метод проверяющий - является ли элемент по указанному индексу локальным минимумом
def is_index_a_local_minimum(arr,index)
	return false if index == 0 && arr.size-1 == index
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


def method_name(arr)
	l1 = arr.uniq
	l2 = l1.map{ |i| arr.count(i) }
	[l1,l2]
end


puts "#{method_name([1,2,5,6,4,1,0,0])}"