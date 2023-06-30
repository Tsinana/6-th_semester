require_relative 'data_list'

class DataListStudentShort < DataList
  def initialize(arg1)
    super(arg1)
    self.subscribers = []
  end

  def get_names
    %w[number fullname git contact]
  end

  def get_data
    super
  end

  def get_info(obj)
    [obj.fullname, obj.git, obj.contact]
  end


  def subscribe(subscriber)
    subscribers << subscriber
  end

  def unsubscribe(subscriber)
    subscribers.delete subscriber
  end

  def notify
    subscribers.each do |subj|
      p "d"
      names = self.get_names
      subj.set_table_data(self.get_data)
      subj.set_table_params(names, names.length)
    end
  end

  private
  attr_accessor :subscribers
end 
