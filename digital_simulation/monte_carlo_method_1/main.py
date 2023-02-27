import random
import numpy as np
import matplotlib.pyplot as plt


def import_data(file_path):
    list_of_data = []
    with open(file_path, "r") as reader:
        for line in reader:
            list_of_data.append(float(line.split()[0]))
    return list_of_data


def create_rnd_points(quatity_of_points, side_of_rectangle_from_x, side_of_rectangle_to_x, side_of_rectangle_from_y,
                      side_of_rectangle_to_y):
    list_of_points_x = []
    list_of_points_y = []
    iterator = 0
    while iterator < quatity_of_points:
        list_of_points_x.append(round(random.uniform(side_of_rectangle_from_x, side_of_rectangle_to_x), 4))
        list_of_points_y.append(round(random.uniform(side_of_rectangle_to_y, side_of_rectangle_from_y, ), 4))
        iterator += 1
    return list_of_points_x, list_of_points_y


def create_rnd_points_ab(quatity_of_points, side_of_rectangle_a, side_of_rectangle_b):
    return create_rnd_points(quatity_of_points, 0, side_of_rectangle_a, 0, side_of_rectangle_b)


def checking_the_conditoin(list_of_points, task_lambda):
    list_of_points_x = list_of_points[0]
    list_of_points_y = list_of_points[1]
    iterator = 0
    len_of_list = len(list_of_points_x)
    list_of_true_points_x = []
    list_of_true_points_y = []
    list_of_false_points_x = []
    list_of_false_points_y = []

    while iterator < len_of_list:
        point = [list_of_points_x[iterator], list_of_points_y[iterator]]
        if task_lambda(point[0], point[1]):
            list_of_true_points_x.append(point[0])
            list_of_true_points_y.append(point[1])
        else:
            list_of_false_points_x.append(point[0])
            list_of_false_points_y.append(point[1])

        iterator += 1
    return list_of_true_points_x, list_of_true_points_y, list_of_false_points_x, list_of_false_points_y


def checking_the_conditoin_for_task_4(list_of_points):
    list_of_points_x = list_of_points[0]
    list_of_points_y = list_of_points[1]
    iterator = 0
    len_of_list = len(list_of_points_x)
    list_of_true_points_x = []
    list_of_true_points_y = []
    list_of_false_points_x = []
    list_of_false_points_y = []

    while iterator < len_of_list:
        point = [list_of_points_x[iterator], list_of_points_y[iterator]]
        r = np.sqrt(point[0] ** 2 + point[1] ** 2)

        if point[0] > 0:
            fi = np.arctan(point[1] / point[0])
        elif point[0] < 0:
            fi = np.pi + np.arctan(point[1] / point[0])
        elif point[0] == 0 and point[1] > 0:
            fi = np.pi / 2
        elif point[0] == 0 and point[1] < 0:
            fi = - np.pi / 2
        else:
            fi = 0

        p = np.sqrt(10 * np.cos(fi) ** 2 + 5 * np.sin(fi) ** 2)
        if r < p:
            list_of_true_points_x.append(point[0])
            list_of_true_points_y.append(point[1])
        else:
            list_of_false_points_x.append(point[0])
            list_of_false_points_y.append(point[1])

        iterator += 1
    return list_of_true_points_x, list_of_true_points_y, list_of_false_points_x, list_of_false_points_y


def task_1(N=100):
    main_x = np.arange(0, 16, 1)
    main_y = np.arange(0, 41, 1)
    tack_lambda = lambda x, y: ((10 * x) / 15) < y < (10 * ((x - 20) / (-5)))
    a = 15
    b = 40
    main_list_of_points = create_rnd_points_ab(N, a, b)
    main_list_of_points = checking_the_conditoin(main_list_of_points, tack_lambda)
    M = len(main_list_of_points[0])
    S = round((M / N) * a * b, 4)
    S0 = 300

    print(f"\n\nЗадача 1"
          f"\nПри N = {N}:"
          f"\n\t\tM = {M}"
          f"\n\t\tS = {S}"
          f"\n\t\tS0 = {S0}")

    plt.figure(figsize=(10, 5))
    plt.plot(main_x, ((10 * main_x) / 15), 'r', linewidth=0.7)
    plt.plot(main_x, 10 * ((main_x - 20) / (-5)), 'r', linewidth=0.7)
    plt.plot(0 * main_y, main_y, 'r', linewidth=0.7)
    plt.plot([0, 0, 15, 15, 0], [0, 40, 40, 0, 0], 'b--', linewidth=0.4)
    plt.plot(main_list_of_points[0], main_list_of_points[1], 'g^')
    plt.plot(main_list_of_points[2], main_list_of_points[3], 'y^')
    plt.grid(True)
    plt.savefig('figure_task_1.png')
    plt.show()


def task_2(N=150):
    main_x = np.arange(0, 7.1, 0.1)
    tack_lambda = lambda x, y: (np.sqrt(29 - 15 * np.cos(x) ** 2)) > y
    a = 7
    b = 7
    main_list_of_points = create_rnd_points_ab(N, a, b)
    main_list_of_points = checking_the_conditoin(main_list_of_points, tack_lambda)
    M = len(main_list_of_points[0])
    S = round((M / N) * a * b, 4)
    S0 = 31.7960  # подсчитано другим ресурсом

    print(f"\n\nЗадача 2"
          f"\nПри N = {N}:"
          f"\n\t\tM = {M}"
          f"\n\t\tS = {S}"
          f"\n\t\tS0 = {S0}")

    plt.figure(figsize=(10, 5))
    plt.plot(main_x, np.sqrt(29 - 15 * np.cos(main_x) ** 2), 'r', linewidth=0.7)
    plt.plot([0, 0, 7, 7, 0], [0, 7, 7, 0, 0], 'b--', linewidth=0.4)
    plt.plot(main_list_of_points[0], main_list_of_points[1], 'g^')
    plt.plot(main_list_of_points[2], main_list_of_points[3], 'y^')
    plt.grid(True)
    plt.savefig('figure_task_2.png')
    plt.show()


def task_3(N=150):
    R = 15
    a = R * 2
    tack_lambda = lambda x, y: (x - R) ** 2 + (y - R) ** 2 < R ** 2
    main_list_of_points = create_rnd_points_ab(N, a, a)
    main_list_of_points = checking_the_conditoin(main_list_of_points, tack_lambda)
    M = len(main_list_of_points[0])
    S = round((M / N) * a ** 2, 4)
    S0 = np.pi * R ** 2
    pi = S / R ** 2

    print(f"\n\nЗадача 3"
          f"\nПри N = {N}:"
          f"\n\t\tM = {M}"
          f"\n\t\tS = {S}"
          f"\n\t\tS0 = {S0}"
          f"\n\t\tpi = {pi}"
          f"\n\t\tpi0 = {np.pi}")

    t = np.arange(0, 2 * np.pi, 0.01)

    plt.figure(figsize=(10, 10))
    plt.plot(R + R * np.cos(t), R + R * np.sin(t), 'r', linewidth=0.7)
    plt.plot([0, 0, a, a, 0], [0, a, a, 0, 0], 'b--', linewidth=0.4)
    plt.plot(main_list_of_points[0], main_list_of_points[1], 'g^')
    plt.plot(main_list_of_points[2], main_list_of_points[3], 'y^')
    plt.grid(True)
    plt.savefig('figure_task_3.png')
    plt.show()


def task_4(N=170):
    a = 8
    b = 6
    main_list_of_points = create_rnd_points(N, -4, 4, -3, 3)
    main_list_of_points = checking_the_conditoin_for_task_4(main_list_of_points)
    M = len(main_list_of_points[0])
    S = round((M / N) * a * b, 4)
    S0 = 23.564

    print(f"\n\nЗадача 4"
          f"\nПри N = {N}:"
          f"\n\t\tM = {M}"
          f"\n\t\tS = {S}"
          f"\n\t\tS0 = {S0}")

    t = np.arange(0, 2 * np.pi, 0.01)
    p = np.sqrt(10 * np.cos(t) ** 2 + 5 * np.sin(t) ** 2)

    plt.figure(figsize=(10, 10))
    plt.plot(p * np.cos(t), p * np.sin(t), 'r', linewidth=0.7)
    plt.plot([-4, -4, 4, 4, -4], [-3, 3, 3, -3, -3], 'b--', linewidth=1)
    plt.plot(main_list_of_points[0], main_list_of_points[1], 'g^')
    plt.plot(main_list_of_points[2], main_list_of_points[3], 'y^')
    plt.grid(True)
    plt.savefig('figure_task_4.png')
    plt.show()


if __name__ == '__main__':
    print("\nВыберите задачу с первой по четвертую (1-4) или все (0):")
    task = int(input())
    print("\nВведите необходимое количество точек:")
    N = int(input())

    print("\nN - общее количество случайных точек;"
          "\nМ - количесвто точек внутри фигуры;"
          "\nS - приблеженная площадь фигуры;"
          "\nS0 - точная площадь фигуры")

    if task == 0:
        task_1(N)
        task_2(N)
        task_3(N)
        task_4(N)
    elif task == 1:
        task_1(N)
    elif task == 2:
        task_2(N)
    elif task == 3:
        task_3(N)
    elif task == 4:
        task_4(N)
