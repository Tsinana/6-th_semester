class DataTable

	def initialize(data)
    self.data = data
  end

  def get_cell(row, col)
    self.data[row][col]
  end

  def num_columns
    self.data[0].length
  end

  def num_rows
    self.data.length
  end

  def set_data(new_data)
    self.data = new_data.dup
  end

  private
    attr_accessor :data
end

