import numpy as np

from classes.model import Model

if __name__ == '__main__':
  count_machine = int(input("Введите количество моделей: "))
  count_details = int(input("Введите объем работ для каждой модели: "))

  new_model = Model(200, 0.3, 0.4, 0.3, 3, 1, 4, 1, 3, 1, 5, 2)
  new_model.start()
#
import tkinter as tk

from classes.form import Form

#
# class App:
#   def __init__(self):
#     self.root = tk.Tk()
#     self.form = Form(self.root)
#     self.button = tk.Button(self.form, text="Нажмите меня")
#     self.button.pack()
#     self.button.bind("<Button-1>", self.handle_button_click)  # привязка функции к событию нажатия на кнопку
#
#   def run(self):
#     self.root.mainloop()
#
#   def handle_button_click(self, event):
#     print("Кнопка была нажата")  # здесь можно вызвать функцию для обработки данных
#
#
# if __name__ == '__main__':
#   app = App()
#   app.run()