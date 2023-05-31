require_relative '../classes/data_table'
require_relative '../classes/data_list'

class DataListStudentShort < DataList
  def get_names
    %w[fullname git contact]
  end

  def get_info(obj)
    [obj.fullname, obj.git, obj.contact]
  end
end
