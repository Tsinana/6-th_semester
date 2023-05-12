from classes.model import Model


class Data_hander:
  def set_parameters(self,input_parameters):
    self.input_parameters = input_parameters


  def run(self):
    input_parameters = self.input_parameters
    self.data = []
    for _ in range(input_parameters[0]):
      new_experiment = Model(input_parameters[1], input_parameters[2], input_parameters[3], input_parameters[4], input_parameters[5], input_parameters[6], input_parameters[7], input_parameters[8], input_parameters[9], input_parameters[10], input_parameters[11], input_parameters[12])
      new_experiment.start()
      self.data.append(new_experiment.get_data())

  def get_data(self):
    data_str = 'Параметры ЭВМ [1,2,3]: общее время работы с момента вкл, общее время выполния задачи, общее время ошидания задачи, общее время ожидание задачь в очереди, задачь выполнено\n\n'
    counter_task = 0
    for task in self.data:
      data_str += f"{counter_task}\t{str(task)}\n"
      counter_task += 1
    return data_str


  def get_mean_data(self):
    data = self.data
    mean_task = data.pop()
    for task in data:
      mean_task = self.plus_result(mean_task, task)
    mean_task = self.div_result(mean_task,len(data))
    return mean_task


  def plus_result(self,result,plus):
    for i in range(len(result)):
      result[i] += plus[i]
    return result

  def div_result(self,result,div):
    for i in range(len(result)):
      result[i] /= div
    return result