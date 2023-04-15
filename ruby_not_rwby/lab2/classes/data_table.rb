class DataTable
	attr_reader :data

	def initialize(data)
    @data = data
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
end