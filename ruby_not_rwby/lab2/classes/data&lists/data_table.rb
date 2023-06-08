class DataTable
	def initialize(data)
    self.data = data
  end

  # Метод. Возвращает ячейку
  def get_cell(row, col)
    self.data[row][col]
  end

  # Метод. Возвращает столбик
  def num_columns
    self.data[0].length
  end

  # Метод. Возвращает строку
  def num_rows
    self.data.length
  end

  # Метод. Устанавливает новое значение
  def set_data(new_data)
    self.data = new_data.dup
  end

  private
    attr_accessor :data
end

