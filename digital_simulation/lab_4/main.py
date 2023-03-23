import random
import numpy as np
import matplotlib.pyplot as plt


def square_method(digit, m):
  if m > 0 and digit > 999 and digit < 10000:
    list_rDigit = []
    for i in range(0, m):
      rDigit = (digit ** 2) % 1000000 // 100
      list_rDigit.append(round(float(rDigit / 10000), 4))
      digit = rDigit
    return list_rDigit
  else:
    return 0


def multiplication_method(core, digit, m):
  if m > 0 and 10000 > digit > 999 and 999 < core < 10000:
    list_rDigit = []
    for i in range(0, m):
      rDigit = core * digit % 1000000
      list_rDigit.append(float((rDigit // 100) / 10000))
      digit = rDigit % 10000
    return list_rDigit
  else:
    return 0


def MCM(constMult, constDiv, digit, m):
  if m > 0 and 999 < digit < 10000 and 999 < constDiv < 10000 and 999 < constMult < 10000:
    list_rDigit = []
    for i in range(0, m):
      digit = (digit * constMult) % constDiv
      list_rDigit.append(round(digit / 10000, 4))
    return list_rDigit
  else:
    return 0


def urand(m):
  if m > 0:
    list_rdigit = []
    for i in range(0, m):
      list_rdigit.append(random.uniform(0, 1))
    return list_rdigit
  else:
    return 0


def plot(list_rDigit):
  xRange = np.arange(0, 1, 0.1)

  n, bins, patches = plt.hist(list_rDigit, xRange, color='#0504aa',
                              alpha=0.7, rwidth=0.85)
  plt.xlabel('Value')
  plt.ylabel('Frequency')
  plt.grid(True)
  plt.show()


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
  print("\nВведите необходимое количество значений:")
  N = int(input())
  list_A = square_method(7153, 100)
  plot(list_A)
  list_A = multiplication_method(5167,3729,100)
  plot(list_A)
  list_A = MCM(1357,9689,1357,100)
  plot(list_A)
  list_A = urand(100)
  plot(list_A)
# See PyCharm help at https://www.jetbrains.com/help/pycharm/
