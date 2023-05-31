class DataList 
	def initialize(data)
    self.data = data
    self.selected = []
  end


# Найти объект по индексу
  def select(number)
    self.selected << number
  end


  def get_selected
    selected.reduce [] do |id_array, index| id_array << data[index].id end 
  end


  def set_data(new_data)
    self.data = new_data.dup
  end


  protected
  def get_names; end


  def get_data
    ans_array = []
    data.map.with_index do |obj, index|
      ans_array.append([index].append(self.get_info(obj)))
    end

    DataTable.new ans_array
  end


  def get_info(obj); end


  private
    attr_accessor :data, :selected
end

