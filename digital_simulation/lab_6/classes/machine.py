import numpy as np


class Machine:
  def __init__(self, INTERVAL, INTERVAL_ERROR):
    self.in_time = 0
    self.t_work = 0
    self.t_wait = 0
    self.t_over = 0
    self.c_items_done = 0
    self.c_items_in_queue = 0
    self.last_detail = 0
    self.INTERVAL = INTERVAL
    self.INTERVAL_ERROR = INTERVAL_ERROR

  # Выполнить одну деталь - учет времени производства
  def do_work(self, detail):
    job = self.generate_interval()

    delta = detail.time - self.in_time
    if self.INTERVAL == 5 and delta :
      print(f"{delta}   {detail.time}  {self.in_time} ")
    if self.in_time > self.last_detail:
      self.c_items_in_queue += 1
    if delta > 0:
      self.t_wait += delta
      self.in_time += delta + job
    else:
      self.t_over += -delta
      self.in_time += job
    self.t_work += job
    self.c_items_done += 1
    detail.time = self.in_time
    return detail

  def get_status(self):
    if self.INTERVAL == 5:
      print()
    return list(map(lambda x: round(x,4),[self.t_work + self.t_wait, self.t_work, self.t_wait,( self.t_wait / (self.t_work + self.t_wait)) * 100, self.t_over, self.c_items_done,self.t_work / self.c_items_done, self.c_items_in_queue]))

  # Генератор случайных интервалов времени между задачами
  def generate_interval(self):
    return self.INTERVAL + np.random.uniform(-self.INTERVAL_ERROR, self.INTERVAL_ERROR)
