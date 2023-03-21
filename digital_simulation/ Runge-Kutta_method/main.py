import math
from prettytable import PrettyTable
import matplotlib.pyplot as plt


class Runge_Kutta:
  list_xk = []
  list_yk = []
  list_zk = []
  list_dely = []
  list_delz = []
  list_truey = []
  list_truez = []

  def __init__(self, f, g, h, x0, y0, z0):
    self.f = f
    self.g = g
    self.h = h
    self.yk = y0
    self.zk = z0
    self.xk = x0
    for i in range(0, 5):
      # while self.xk <= 1:
      self.generation_kplus1()

  def generation_kplus1(self):  # да да - целый блок только для примера
    k1 = self.h * self.f(self.xk, self.yk, self.zk)
    l1 = self.h * self.g(self.xk, self.yk, self.zk)
    k2 = self.h * self.f(self.xk + self.h / 2, self.yk + k1 / 2, self.zk + l1 / 2)
    l2 = self.h * self.g(self.xk + self.h / 2, self.yk + k1 / 2, self.zk + l1 / 2)
    k3 = self.h * self.f(self.xk + self.h / 2, self.yk + k2 / 2, self.zk + l2 / 2)
    l3 = self.h * self.g(self.xk + self.h / 2, self.yk + k2 / 2, self.zk + l2 / 2)
    k4 = self.h * self.f(self.xk + self.h, self.yk + k3, self.zk + l3)
    l4 = self.h * self.g(self.xk + self.h, self.yk + k3, self.zk + l3)

    del_yk = round((1 / 6) * (k1 + 2 * k2 + 2 * k3 + k4), 9)
    del_zk = round((1 / 6) * (l1 + 2 * l2 + 2 * l3 + l4), 9)

    self.list_dely.append(del_yk)
    self.list_delz.append(del_zk)
    self.list_xk.append(self.xk)
    self.list_yk.append(self.yk)
    self.list_zk.append(self.zk)

    self.yk = round(self.yk + del_yk, 9)
    self.zk = round(self.zk + del_zk, 9)
    self.xk = round(self.xk + self.h, 9)

  def set_true(self, f, g):
    for xk in self.list_xk:
      self.list_truey.append(round(f(xk), 9))
      self.list_truez.append(round(g(xk), 9))

  def plot(self):
    plt.title('Лабораторная работа №3', fontsize=20, fontname='Times New Roman')
    plt.plot(self.list_xk, self.list_truey, 'y', label=r'Точное решение для y(t)')
    plt.plot(self.list_xk, self.list_truez, 'lime', label=r'Точное решение для x(t)')
    plt.plot(self.list_xk, self.list_yk, 'r-.', label=r'Метод Рунге-Кутта для для y(t)')
    plt.plot(self.list_xk, self.list_zk, 'b-.', label=r'Метод Рунге-Кутта для для x(t)')
    plt.xlabel(r'$x$', fontsize=14)
    plt.ylabel(r'$f(x)$', fontsize=14)
    plt.grid(True)
    plt.legend(loc='best', fontsize=10)
    plt.savefig('figure_with_legend.png')
    plt.show()

  def table_draw(self):
    mytable = PrettyTable()
    mytable.add_column("k", range(0, len(self.list_xk)))
    mytable.add_column("x", self.list_xk)
    mytable.add_column("y", self.list_yk)
    mytable.add_column("z", self.list_zk)
    mytable.add_column("Δy", self.list_dely)
    mytable.add_column("Δz", self.list_delz)
    mytable.add_column("y ист", self.list_truey)
    mytable.add_column("z ист", self.list_truez)
    print(mytable)


if __name__ == '__main__':
  try:
    print("\nВыберите желаемую задачу. 0 - контрольная, 1 - тест 1, 2 - тест 2: ")
    taskChoice = int(input())
    print("\nВведите желаемый шаг: ")
    taskH = float(input())
    if taskChoice == 1:
      f = lambda x, y, z: -2 * z + 4 * y
      g = lambda x, y, z: -z + 3 * y
      gt = lambda t: 4 * math.exp(-t) - math.exp(2 * t)
      ft = lambda t: math.exp(-t) - math.exp(2 * t)

      task_1 = Runge_Kutta(g, f, taskH, 0, 0, 3)
      task_1.set_true(ft, gt)
      task_1.table_draw()
      task_1.plot()
    elif taskChoice == 2:
      f = lambda x, y, z: y
      g = lambda x, y, z: 2 * y
      gt = lambda t: math.exp(2 * t) + 1
      ft = lambda t: 2 * math.exp(2 * t)

      task_1 = Runge_Kutta(g, f, taskH, 0, 2, 2)
      task_1.set_true(ft, gt)
      task_1.table_draw()
      task_1.plot()
    else:
      f = lambda x, y, z: z
      g = lambda x, y, z: (2 * x * z) / (x * x + 1)
      task_1 = Runge_Kutta(f, g, taskH, 0, 1, 3)
  except BaseException:
    print('Ошибка')
