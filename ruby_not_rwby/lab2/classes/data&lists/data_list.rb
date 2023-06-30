require_relative 'data_table'

class DataList 
	def initialize(data)
    self.data = data
    self.selected = []
  end

  # Метод. Ищет объект по индексу
  def select(number)
    self.selected << number
  end

  # Метод. Возвращает массив выбраных записей
  def get_selected
    selected.reduce [] do |id_array, index| id_array << data[index].id end 
  end

  # Метод. Устанавливает полностью новые данные 
  def set_data(new_data)
    self.data = new_data.dup
  end

  def get_list_objs
    data
  end

  protected
  def get_names; end

  # Шаблонный метод.
  def get_data
    ans_array = []
    data.map.with_index do |obj, index|
      ans_array.append(self.get_info(obj).unshift(index))
    end

    DataTable.new ans_array
  end

  protected

  def get_info(obj); end

  private
    attr_accessor :data, :selected
end