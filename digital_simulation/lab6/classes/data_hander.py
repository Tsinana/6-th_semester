from classes.model import Model


class Data_hander:
  def run(self,data):
    self.data = data
    processed_data = []
    for _ in range(data[0]):
      new_experiment = Model(data[1],data[2],data[3],data[4],data[5],data[6],data[7],data[8],data[9],data[10],data[11],data[12])
      new_experiment.start()
      processed_data.append(new_experiment.get_data())
    self.analysis(processed_data)

  def analysis(self,data):
