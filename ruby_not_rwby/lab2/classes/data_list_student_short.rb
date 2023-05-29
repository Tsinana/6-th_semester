require '../classes/data_list'
require '../classes/data_table'

class DataListStudentShort < DataList
  def get_names
    %w[fullname git contact]
  end


  def get_data
    result = data.map!.with_index do |row, index|
      row.unshift(index).delete_at(1)
    end
    DataTable.new result
  end
end
