import numpy as np


class Machine:
  def __init__(self):
    self.t_to_break = self.generate_repair_cooldown()
    self.t_work = 0
    self.t_set_up = 0
    self.t_repair = 0
    self.t_lost = 0
    self.c_items_done = 0
    self.c_breaks = 0

  # Выполнить одну деталь - учет времени производства и проверка на поломку
  def do_work(self):
    set_up = self.generate_set_up_time()
    work = self.generate_task_execution_time()
    self.t_to_break -= set_up + work

    if self.t_to_break < 0:
      self.repair_machin(set_up, work)
    else:
      self.t_work += work
      self.t_set_up += set_up
      self.c_items_done += 1

  # Ремонт машины - установка нового времени до поломки и учет потерянного времени с вызов do_work()
  def repair_machin(self, set_up, work):
    repair = self.generate_repair_time()
    self.t_repair += repair
    self.t_lost += set_up + work + repair
    self.t_to_break = self.generate_repair_cooldown()
    self.c_breaks += 1
    self.do_work()

  # Получить все поля машины
  def get_status(self):
    return [round(self.t_work + self.t_set_up + self.t_lost - self.t_repair, 4), round(self.t_work + self.t_set_up, 4),
            round(self.t_repair, 4), round(self.t_repair, 4), round(self.c_breaks, 4)]

  # Генератор случайного времени выполнения задачи
  @staticmethod
  def generate_task_execution_time():
    return np.random.normal(loc=0.5, scale=0.1)

  # Генератор времени на починку
  @staticmethod
  def generate_repair_cooldown():
    return np.random.normal(loc=20, scale=2)

  # Генератор времени на починку
  @staticmethod
  def generate_repair_time():
    return np.random.uniform(low=0.1, high=0.5)

  # Генератор времени на наладку
  @staticmethod
  def generate_set_up_time():
    return np.random.uniform(low=0.2, high=0.5)
