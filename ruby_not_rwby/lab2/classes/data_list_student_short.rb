class DataListStudentShort < data_list


  def get_names
    fields = []
    self.instance_variables.each do |var|
      key = var.to_s.delete("@")
      if self.respond_to?(key) || key != 'id'
        value = self.send(key)
        fields << "#{key}: #{value}" # важный пробел
      end
    end
    fields
  end


  def get_data
  end
end