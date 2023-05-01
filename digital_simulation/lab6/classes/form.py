class Form:
  def __init__(self,path_input,path_output):
    self.path_input = path_input
    self.path_output = path_output

  def get_data(self):
    with open(self.path_input,'r') as file:
      str = file.read()
      data = str.split(' ')
    data = list(map(float,data))
    data[0] = int(data[0])
    data[1] = int(data[1])
    return data

  def write_data(self,data):
    with open(self.path_output,'w') as file:
        file.write("data")