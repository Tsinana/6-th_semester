from classes.data_hander import Data_hander
from classes.form import Form


class App:
  def __init__(self):
    self.form = Form('data/input.txt','data/output.txt')
    self.data_hander = Data_hander()

  def run(self):
    data = self.form.get_data()
    self.data_hander.set_parameters(data)
    self.data_hander.run()
    self.form.write_data(self.data_hander.get_mean_data())
    self.form.path_output = 'data/log.txt'
    self.form.write_data(self.data_hander.get_data())


if __name__ == '__main__':
  app = App()
  app.run()