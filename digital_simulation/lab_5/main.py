import numpy as np
from prettytable import PrettyTable


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
    return [round(self.t_work + self.t_set_up, 4), round(self.t_work, 4), round(self.t_set_up, 4),
            round(self.t_lost, 4), round(self.t_lost - self.t_repair, 4), round(self.t_repair, 4),
            round(self.c_items_done, 4), round(self.c_breaks, 4)]

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


# Генератор случайных интервалов времени между задачами
def generate_interval():
  return np.random.exponential()


def print_table(data, field_names):
  table = PrettyTable()
  table.field_names = field_names
  table.add_rows(data)
  print(table)


def model_machine(count_machine, count_details):
  data = []
  for _ in range(count_machine):
    my_machine = Machine()
    waiting = 0

    old_status = my_machine.get_status()
    my_machine.do_work()
    new_status = my_machine.get_status()
    runtime = new_status[0] + new_status[1] + new_status[3] - old_status[0] - old_status[1] - old_status[3]

    for _ in range(count_details):
      interval = generate_interval()
      waiting = round(interval - runtime, 4)

      old_status = new_status
      my_machine.do_work()
      new_status = my_machine.get_status()
      runtime = new_status[0] + new_status[1] + new_status[3] - old_status[0] - old_status[1] - old_status[3]

    status_machine = my_machine.get_status()
    status_machine.append(waiting)
    data.append(status_machine)

  field_names = ["Работа станка", "Выполнение детали", "Настройка станка", "Игра в бирюльки", "Утрата работы",
                 "Ремонт станка", "Сделано деталей", "Поломок", "Простой"]
  print_table(data, field_names)


if __name__ == '__main__':
  count_machine = int(input("Введите количество моделей: "))
  count_details = int(input("Введите объем работ для каждой модели: "))

  model_machine(count_machine, count_details)
