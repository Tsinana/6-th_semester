import numpy as np

from classes.Detail import Detail
from classes.Machine import Machine


class Model:
  def __init__(self, count_details, task_p_for_the_second_machine_from_first_machine,
               task_p_for_the_first_machine, task_p_for_the_second_machine,
               task_generation_interval, task_generation_interval_error,
               interval_for_first_machine, interval_error_for_first_machine,
               interval_for_second_machine, interval_error_for_second_machine,
               interval_for_third_machine, interval_error_for_third_machine):
    self.count_details = count_details
    self.task_generation_interval = task_generation_interval
    self.task_generation_interval_error = task_generation_interval_error
    self.task_p_for_the_first_machine = task_p_for_the_first_machine
    self.task_p_for_the_second_machine = task_p_for_the_second_machine
    self.task_p_for_the_second_machine_from_first_machine = task_p_for_the_second_machine_from_first_machine
    self.in_time = 0

    self.first_machine = Machine(interval_for_first_machine, interval_error_for_first_machine)
    self.second_machine = Machine(interval_for_second_machine, interval_error_for_second_machine)
    self.third_machine = Machine(interval_for_third_machine, interval_error_for_third_machine)

    self.queue_for_first_machine = []
    self.queue_for_second_machine = []
    self.queue_for_third_machine = []

  def start(self):
    self.generate_queue()
    self.start_first_machine()
    self.queue_for_second_machine.sort(key=lambda x: x.time)
    self.queue_for_third_machine.sort(key=lambda x: x.time)
    self.start_machine(self.queue_for_second_machine, self.second_machine)
    self.start_machine(self.queue_for_third_machine, self.third_machine)
    print(self.first_machine.get_status())
    print(self.second_machine.get_status())
    print(self.third_machine.get_status())

  def start_machine(self, queue, machine):
    for detail in queue:
      _ = machine.do_work(detail)

  def start_first_machine(self):
    for detail in self.queue_for_first_machine:
      detail_reference = self.first_machine.do_work(detail)
      detail_to_machine = self.generate_0to1()
      if detail_to_machine <= self.task_p_for_the_second_machine_from_first_machine:
        self.queue_for_second_machine.append(detail_reference)
      else:
        self.queue_for_third_machine.append(detail_reference)

  def generate_queue(self):
    for i in range(0, self.count_details):
      interval = self.generate_interval()
      self.in_time += interval
      new_detail = Detail(self.in_time)

      detail_to_machine = self.generate_0to1()
      if detail_to_machine <= self.task_p_for_the_first_machine:
        self.queue_for_first_machine.append(new_detail)
      elif detail_to_machine <= self.task_p_for_the_second_machine + self.task_p_for_the_first_machine:
        self.queue_for_second_machine.append(new_detail)
      else:
        self.queue_for_third_machine.append(new_detail)

  # Генератор случайных интервалов времени между задачами
  def generate_interval(self):
    return self.task_generation_interval + np.random.uniform(-self.task_generation_interval_error,
                                                             self.task_generation_interval_error)

  # Генератор случайных чисел от 0 до 1
  def generate_0to1(self):
    return np.random.uniform(0, 1)
