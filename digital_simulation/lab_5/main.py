# Программа требует в файле импут выполнения след действий
# Введите количество эксперементов:
# Введите количество задачь для каждого эксперемента


import numpy as np
from prettytable import PrettyTable

from classes.machine import Machine


# Генератор случайных интервалов времени между задачами
def generate_interval():
  return np.random.exponential()


def print_table(data, field_names, file):
  table = PrettyTable()
  table.field_names = field_names
  if isinstance(data[0], list):
    table.add_rows(data)
  else:
    table.add_row(data)
  file.write(table.get_string())


def print_result(data):
  with open("input.txt", "r") as f:
    count_machine = int(f.readline())
    count_details = int(f.readline())
  with open('result.txt', 'w') as file:
    file.write(f'Далее представлена таблица с результатами {count_machine} экспериментов c {count_details} задач в каждом эксперименте в часах\n\n')
    file.write('Таблица 1 -- Параметры станков в конце эксперемента\n')
    field_names = ["Общее время работы станка","Общее время выполния всех деталей", "Общее время простоя станка",
                   "Общее время затраченное на ремонт станка", "Количество поломок"]
    print_table(data, field_names, file=file)

    # averages = []
    # for i in range(len(data[0])):
    #   total = 0
    #   for j in range(len(data)):
    #     total += data[j][i]
    #   averages.append(round(total / len(data), 4))
    # averages[6] = int(round(averages[6], 0))
    # averages[7] = int(round(averages[7], 0))
    # file.write('\n\nТаблица 2 -- Среднее значение кажного параметра\n')
    # print_table(averages, field_names, file=file)

    # file.write('\nТаблица 3 -- Времени требуется для выполниния одной задачи\n')
    # field_names = ["Всего времени", "Настройка станка", "Выполнение детали", "Погрешность поломки"]
    # all_details = averages[6]
    # all_time = (averages[0] + averages[3]) / all_details
    # time_to_detail = [round(all_time, 2), round(averages[2] / all_details, 2), round(averages[1] / all_details, 2),
    #                   round(averages[3] / all_details, 2)]
    # percentages = [100.0, round((averages[2] / all_details) / all_time * 100, 2),
    #                round((averages[1] / all_details) / all_time * 100, 2),
    #                round((averages[3] / all_details) / all_time * 100, 2)]
    # my_string_list = list(map(str, percentages))
    # my_string_list = list(map(lambda x: x + '%', my_string_list))
    # new_data = [time_to_detail, my_string_list]
    # print_table(new_data, field_names, file=file)


def model_machine(count_machine, count_details):
  data = []
  for _ in range(count_machine):
    my_machine = Machine()
    waiting = 0
    over = 0

    old_status = my_machine.get_status()
    my_machine.do_work()
    new_status = my_machine.get_status()
    runtime = new_status[0] + new_status[1] + new_status[3] - old_status[0] - old_status[1] - old_status[3]

    for _ in range(count_details):
      interval = generate_interval()
      delta = round(interval - runtime, 4)
      if delta < 0:
        over += -delta
      else:
        waiting += delta

      old_status = new_status
      my_machine.do_work()
      new_status = my_machine.get_status()
      runtime = new_status[0] + new_status[1] + new_status[3] - old_status[0] - old_status[1] - old_status[3]

    status_machine = my_machine.get_status()
    oll_time_prostoi = round(status_machine[2] + waiting, 4)
    status_machine[2] = oll_time_prostoi
    status_machine[0] = round (oll_time_prostoi + status_machine[0], 4)
    data.append(status_machine)
    # data[3] += waiting

  print_result(data)


if __name__ == '__main__':
  with open("input.txt", "r") as f:
    count_machine = int(f.readline())
    count_details = int(f.readline())
  model_machine(count_machine, count_details)
