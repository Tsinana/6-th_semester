import numpy as np

from classes.Model import Model

if __name__ == '__main__':
  count_machine = int(input("Введите количество моделей: "))
  count_details = int(input("Введите объем работ для каждой модели: "))

  new_model = Model(200, 0.3, 0.4, 0.3, 3, 1, 4, 1, 3, 1, 5, 2)
  new_model.start()
