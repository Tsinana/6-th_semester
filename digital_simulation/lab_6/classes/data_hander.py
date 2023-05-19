import math

from prettytable import PrettyTable

from classes.model import Model


class Data_hander:
  last_experiment = 0
  count_tasks = 0

  def set_parameters(self, input_parameters):
    self.input_parameters = input_parameters

  def run(self):
    input_parameters = self.input_parameters
    self.data = []
    self.count_tasks = input_parameters[0]
    for _ in range(input_parameters[0]):
      new_experiment = Model(input_parameters[1], input_parameters[2], input_parameters[3], input_parameters[4],
                             input_parameters[5], input_parameters[6], input_parameters[7], input_parameters[8],
                             input_parameters[9], input_parameters[10], input_parameters[11], input_parameters[12])
      new_experiment.start()
      self.last_experiment = new_experiment
      self.data.append(new_experiment.get_data())

  def data_to_string(self, data):
    data_str = 'Параметры ЭВМ [1,2,3]: общее время работы с момента вкл, общее время выполния задачи, общее время ошидания задачи, общее время ожидание задачь в очереди, задачь выполнено\n\n'
    counter_task = 0
    for task in data:
      data_str += f"{counter_task}\t{str(task)}\n"
      counter_task += 1
    return data_str

  def get_mean_data(self):
    data = self.data
    mean_task = data.pop()
    for task in data:
      for machine_i in range(len(task)):
        mean_task[machine_i] = self.add_two_array(mean_task[machine_i], task[machine_i])
    for machine_i in range(len(mean_task)):
      mean_task[machine_i] = self.round_array(self.div_array(mean_task[machine_i], len(data) + 1), 0)
    return mean_task

  def round_array(self, arrayA, round_number):
    for i in range(len(arrayA)):
      arrayA[i] = round(arrayA[i], round_number)
    return arrayA

  def add_two_array(self, arrayA, arrayB):
    if len(arrayA) != len(arrayB):
      return 0
    for i in range(len(arrayA)):
      arrayA[i] += arrayB[i]
    return arrayA

  def div_array(self, array, div):
    for i in range(len(array)):
      array[i] /= div
    return array

  def data_to_table(self, data):
    table_name = f"Таблица 1 -- таблица с результатами {self.count_tasks} экспериментов c {self.last_experiment.count_details} задач в каждом эксперименте\n"
    analyze = self.from_mean_analyze(data)
    field_names = ['Общее время работы ЭВМ с момента запуска', 'Общее время выполния всех задач', 'Общее время простоя',
                   'Общее время простоя (%)', 'Общее время простаивания задачи в очереди',
                   'Количество выполненых задач', 'Среднее время выполнения задачи',
                   'Количество задачь в очереди на момент поступления последней задачи']
    data = self.data_to_str_with_iff(data, [0, 1, 2, 4, 6])
    return table_name + self.get_table(data, field_names) + analyze

  def data_to_str_with_iff(self, data, iff):
    for i in range(len(data)):
      for j in range(len(data[i])):
        if j in iff:
          data[i][j] = f"{int(data[i][j] / 60)} часов и {int(data[i][j] % 60)} минут"
    return data

  def get_table(self, data, field_names):
    table = PrettyTable()
    table.field_names = field_names
    for task in data:
      table.add_row(task)
    table.add_column("ЭВМ", [2, 1, 3])
    return table.get_string()

  def from_mean_analyze(self, data):

    all_details = self.last_experiment.count_details
    all_time_details = self.last_experiment.in_time
    intansive_canals = round(all_details / all_time_details, 2)

    ans_str = f"\n\nТаблица 2 -- Общие характеристики эксперемента\n"
    table = PrettyTable()
    table.field_names = ['Описание данных', 'Значение данных', 'Единица измерения']
    table.align["Описание данных"] = "l"

    table.add_row(['Всего задач', all_details, 'ед.'])

    # max затраченное время
    max_time = data[0][0]
    for machine in data:
      if max_time < machine[0]:
        max_time = machine[0]
    table.add_row(['Общее затраченное время', f"{int(max_time / 60)}.{int(max_time % 60)}", 'ч.'])

    # Среднее время нагрузки ЭВМ
    mean_working = 0
    for machine in data:
      mean_working += machine[1]
    mean_working /= len(data)
    table.add_row(['Среднее время нагрузки ЭВМ', f"{int(mean_working / 60)}.{int(mean_working % 60)}", 'ч.'])

    # Среднее время простоя
    mean_all_time_chillout = 0
    for i in range(len(data)):
      mean_all_time_chillout += data[i][2]
    mean_all_time_chillout /= len(data)
    table.add_row(['Среднее время простоя', f"{int(mean_all_time_chillout / 60)}.{int(mean_all_time_chillout % 60)}",'ч.'])

    # Среднее время простаивания задачи
    mean_all_time_task_chillout = 0
    for i in range(len(data)):
      mean_all_time_task_chillout += data[i][4]
    mean_all_time_task_chillout /= len(data)
    table.add_row(['Среднее время простаивания задачи',
                   f"{int(mean_all_time_task_chillout / 60)}.{int(mean_all_time_task_chillout % 60)}", 'ч.'])

    # Осталось задач в очереди
    count_task_in_queue = data[0][7] + data[2][7]
    table.add_row(['Осталось задач в очереди', count_task_in_queue, 'ед.'])

    # Среднее время нагрузки ЭВМ
    table.add_row([' ', ' ', ' '])
    table.add_row(['Параметры вычислимые по формулам: ', ' ', ' '])
    table.add_row([' ', ' ', ' '])

    # Абсолютная пропускная способность
    lya = round(all_details / all_time_details * 60, 2)
    table.add_row(['Абсолютная пропускная способность', lya, 'зад./ч.'])

    # Cреднее время обслуживания одного задания
    T_cp = round(self.last_experiment.task_p_for_the_first_machine * self.last_experiment.interval_for_first_machine + \
                 self.last_experiment.task_p_for_the_second_machine * self.last_experiment.interval_for_second_machine + \
                 (
                       1 - self.last_experiment.task_p_for_the_second_machine - self.last_experiment.task_p_for_the_first_machine) * self.last_experiment.interval_for_third_machine + \
                 self.last_experiment.task_p_for_the_second_machine_from_first_machine * self.last_experiment.interval_for_second_machine + \
                 (
                       1 - self.last_experiment.task_p_for_the_second_machine_from_first_machine) * self.last_experiment.interval_for_third_machine,
                 2)
    table.add_row(['Cреднее время обслуживания одного задания', T_cp, 'мин.'])

    # Интенсивность потока обслуживания
    nu = round(1 / T_cp * 60, 2)
    table.add_row(['Интенсивность потока обслуживания', nu, 'зад./ч.'])

    # Интенсивность нагрузки системы
    p = round(lya / nu, 2)
    table.add_row(['Интенсивность нагрузки системы', p, 'степень согласования'])

    # Вероятность простоя системы
    P_0 = round(math.pow((1 + p + (p * p) / 2 + (p ** 3) / (2 * 3) + (p ** 4) / (2 * 3 * (3 - p))), -1), 2)
    table.add_row(['Вероятность простоя системы', P_0, ' '])

    # Вероятность образования очереди
    P_och = round(((p ** 4) / (2 * 3 * (3 - p)) * P_0), 2)
    table.add_row(['Вероятность образования очереди', P_och, ' '])

    # Среднее число заявок в очереди
    L_och = round(((3 / (3 - p)) * P_0), 2)
    table.add_row(['Среднее число заявок в очереди', L_och, 'ед.'])

    # Среднее время ожидания в очереди
    T_och = round((L_och * 60)/ lya, 2)
    table.add_row(['Среднее время ожидания в очереди', T_och, 'час.'])

    # Среднее время пребывания в очереди
    # T_och = round(T_och / lya, 2)
    # table.add_row(['Среднее время ожидания в очереди', T_och, ' '])

    return ans_str + table.get_string()
