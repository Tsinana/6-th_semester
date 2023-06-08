require_relative 'student_list_strategy'
require 'yaml'

class StudentListYaml < SuperStudentList
  def list_hash_from_str(str)
    YAML.load(str).map {|hash| hash.transform_keys(&:to_sym)}
  end

  def list_hash_to_str(list_hash)
    list_hash.map{ |hash| hash.transform_keys(&:to_s)}.to_yaml
  end
end