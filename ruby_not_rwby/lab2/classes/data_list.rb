class DataList
  attr_accessor :selected
	attr_reader :data

	def initialize(data)
    @data = data
    self.selected = []
  end


# Найти объект по индексу
  def select(number)
    self.selected << number
  end

  def get_selected
    id_array = []
    self.selected.each do |index|
      id_array << self.data[index]#.id
    end
    id_array
  end


  def get_names
  end

  def get_data
  end
end