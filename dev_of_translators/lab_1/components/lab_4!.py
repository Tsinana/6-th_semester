  class lab_41:

    def open_arr(arr):
      new_arr = []
      for i in arr:
        for j in i:
          new_arr.append(j)
      return new_arr

    def character_search(arr, search_arr, start_iter):
      ok = 0
      iter = start_iter
      while iter < len(arr) and ok != 1:
        for el in search_arr:
          if el == arr[iter]:
            ok = 1
        if (ok == 0):
          iter += 1
      return iter

    def checking_a_number(el):
      if "N" in el or "C" in el or "I" in el or el == 'R3':
        return True
      return False

    # множитель
    def Factor(in_factor):
      iter = 0
      #  Проверка на обращение к массиву или к функции
      if len(in_factor) > 1:

        left_rart = in_factor[0:len(in_factor)]
        if len(left_rart) > 1:
          if (["R7"] in left_rart or ["R8"] in left_rart):
            if "I" in in_factor[0][0]:
              open_bracket = character_search(in_factor, ["R7"], 0)
              close_bracket = character_search(in_factor, ["R7"], 0)
              if open_bracket == len(in_factor) or close_bracket == len(in_factor):
                return False
              if (open_bracket - close_bracket == 1):
                print("При обращении к массиву не задали параметры")
                return False
              perem = open_bracket + 1
              while close_bracket - perem >= 1:

                end_perem = character_search(in_factor, ["R11"], perem)
                if (in_factor[end_perem] != ["R11"]):
                  if not Expression(left_rart[perem:close_bracket]):
                    return False
                if not Expression(left_rart[perem:end_perem]):
                  return False
                perem = end_perem + 1
              return True
          elif (["R3"] in left_rart and ["R2"] in left_rart):
            if "I" in in_factor[0][0]:
              open_bracket = character_search(in_factor, ["R7"], 0)
              close_bracket = character_search(in_factor, ["R7"], 0)
              if (open_bracket - close_bracket == 1):
                print("При обращении к массиву не задали параметры")
                return False
              perem = open_bracket + 1
              while close_bracket - perem >= 1:

                end_perem = character_search(in_factor, ["R11"], perem)
                if (in_factor[end_perem] != ["R11"]):
                  if not Expression(left_rart[perem:close_bracket]):
                    return False
                if not Expression(left_rart[perem:end_perem]):
                  return False
                perem = end_perem + 1
              return True

      if "N" in in_factor[iter][0] or "C" in in_factor[iter][0]:
        return True
      elif "I" in in_factor[iter][0]:
        return True
      elif ['R3'] == in_factor[iter]:
        new_iter = character_search(in_factor, ["R2"], iter)
        if in_factor[new_iter] == ['R2']:
          if Expression(in_factor[iter + 1:new_iter - 1]):
            return True
        return False
      return False

    # слагаемое
    def Adden(in_expr):
      # если выражение не нулевое
      # (нулевое выражение не считается за ошибку)
      if (len(in_expr) != 0):
        iter = 0
        new_iter = character_search(in_expr, [['O3'], ['O4']], iter)
        if (Factor(in_expr[iter:new_iter])):
          iter = new_iter + 1
          while (iter < len(in_expr)):
            new_iter = character_search(in_expr, [['O3'], ['O4']], iter)
            if (Factor(in_expr[iter:new_iter])):
              iter = new_iter + 1
            else:
              return False
        else:
          return False
      return True

    def Expression(in_expr):
      # если выражение не нулевое
      # (нулевое выражение не считается за ошибку)
      if (len(in_expr) != 0):
        iter = 0
        new_iter = character_search(in_expr, [['O1'], ['O2']], iter)
        if (Adden(in_expr[iter:new_iter])):
          iter = new_iter + 1
        else:
          return False

        while (iter < len(in_expr)):
          new_iter = character_search(in_expr, [['O1'], ['O2']], iter)
          if (Adden(in_expr[iter:new_iter])):
            iter = new_iter + 1
          else:
            return False
      return True

    # Оператор присваивания
    def Assignment(in_assig):
      iter = character_search(in_assig, [["O12"]], 0)
      if iter == len(in_assig):
        return False
      else:
        #  Проверяем левую чать оператора на обращение к элементу массива
        left_rart = in_assig[0:iter]
        if len(left_rart) > 1:
          if (["R7"] in left_rart and ["R8"] in left_rart):
            if ("I" in in_assig[0][0] and Expression(left_rart[2:len(left_rart) - 1]) and
                Expression(in_assig[iter + 1:len(in_assig)])):
              return True
          return False
        param = character_search(in_assig, [["R4"]], 0)
        if param - iter == 1:
          return False
        if ("I" in in_assig[0][0] and Expression(in_assig[iter + 1:len(in_assig)])):
          return True
        print("error: присваивания не пршёл проверку", in_assig)
        return False

    # Условие
    def Condition(in_cond):
      iter = character_search(in_cond, [['06'], ['07'], ['O8'], ['O9'], ['O10'], ["O11"]], 0)
      if (iter == len(in_cond)):
        return False
      else:
        if Expression(in_cond[0:iter]) and Expression(in_cond[iter + 1:len(in_cond)]):
          return True
        else:
          print("Error Условие: ", in_cond)
          return False

    # Условный оператор
    def Conditional_operator(in_if):
      if (["W3"] in in_if):
        open_cond = character_search(in_if, [["R3"]], 1)
        close_cond = character_search(in_if, [["R2"]], 1)
        if (open_cond == close_cond - 1):
          print("Условие не задано")
          return False
        elif close_cond == len(in_if):
          print("Условие. Не нашли закрывающую скобку")
          return False
        else:
          if (Condition(in_if[open_cond + 1:close_cond])):
            open_oper = character_search(in_if, [["R12"]], 1)
            close_oper = character_search(in_if, [["R13"]], 1)
            if (close_oper == len(in_if)):
              print("Условный оператор: не нашли ,},")
              return False
            if (open_oper == close_oper - 1):
              print("Операторы в if не заданы")
              return False
            else:
              open_oper = character_search(in_if, [["R4"]], open_oper) + 1
              if (Program(in_if[open_oper:close_oper])):
                # Проверим наличие else
                if (close_oper != len(in_if) and ["W4"] in in_if):
                  open_oper = character_search(in_if, [["R12"]], close_oper)
                  close_oper = character_search(in_if, [["R13"]], close_oper + 1)
                  if (close_oper == len(in_if)):
                    print("Условный оператор: не нашли ,},")
                    return False
                  if (open_oper == close_oper - 1):
                    print("Операторы в if не заданы")
                    return False
                  else:
                    return True
                return True
              else:
                return False
          else:
            return False
      else:
        print("if не найден")
        return False

    def Analize_functin(in_f):
      iter = character_search(in_f, [["O12"]], 0)
      if iter == len(in_f):
        return False
      else:
        if not "I" in in_f[0][0]:
          print("Имя переменной функции задано неверно")
          return False
        open_cond = character_search(in_f, [["R3"]], 1)
        close_cond = character_search(in_f, [["R2"]], 1)
        if open_cond == len(in_f) or close_cond == len(in_f):
          print("Круглые скобки в функции")
          return False
        # Проверка параметров функции
        param = open_cond + 1
        while close_cond - param >= 1:
          if "I" in in_f[param][0]:
            if (close_cond - param == 1):
              param += 1
            else:
              if ["R11"] == in_f[param + 1]:
                param += 2
              else:
                print("Разделитель в параметрах функции задан неверно")
                return False
          else:
            print("Перемная в параметрах функции задана неверно")
            return False
        open_cond = character_search(in_f, [["R12"]], 1)
        close_cond = character_search(in_f, [["W18"]], 1)
        # Проверяем наличие return
        if close_cond == len(in_f):
          print("return не задан")
          return False
        # проверка параметров функции
        if not Program(in_f[open_cond + 2:close_cond]):
          print("Операторы функции не прошли проверку")
          return False
        open_cond = character_search(in_f, [["R3"]], close_cond)
        close_cond = character_search(in_f, [["R2"]], open_cond)
        if open_cond == len(in_f) or close_cond == len(in_f):
          print("Круглые скобки в функции в return")
          return False
        if (close_cond - open_cond == 1):
          print("return не имеет выражения")
          return False
        if (Expression(in_f[open_cond + 1:close_cond])):
          return True
        return False

    # Оператор цикла
    def analize_while(in_w):
      if (["W5"] in in_w):
        open_cond = character_search(in_w, [["R3"]], 1)
        close_cond = character_search(in_w, [["R2"]], 1)
        if (open_cond == close_cond - 1):
          print("Условие не задано(while)")
          return False
        else:
          if (Condition(in_w[open_cond + 1:close_cond])):
            open_oper = character_search(in_w, [["R12"]], 1)
            close_oper = character_search(in_w, [["R13"]], 1)
            if (close_oper == len(in_w)):
              print("Условный оператор: не нашли ,},")
              return False
            if (open_oper == close_oper - 1):
              print("Операторы в while не заданы")
              return False
            else:
              open_oper = character_search(in_w, [["R4"]], open_oper)
              if (Program(in_w[open_oper + 1:close_oper])):
                return True
              else:
                return False
          else:
            return False
      else:
        print("while не найден")
        return False

    def Operators(s, numb):
      if numb == 1:
        return analize_while(s)
      if numb == 2:
        return Analize_functin(s)
      if numb == 3:
        return Conditional_operator(s)
      if numb == 4:
        return Assignment(s)
      print("EROOOOOOOOR!!!")
      return False

    def Program(in_prog):
      iter = 0
      if in_prog == []:
        print("Пустая ппрограмма")
        return False
      else:
        while (iter < len(in_prog)):
          new_iter = character_search(in_prog, [["R4"]], iter)
          # Проверка на условный оператор
          if ["W3"] in in_prog[iter:new_iter]:
            # Ищем закрывающую фигурную скобку
            new_iter = character_search(in_prog, [["R13"]], new_iter)
            # Если мы её не нашли и упёрлись в конец программы
            if (new_iter == len(in_prog)):
              return False
            # Проверка на потерянную }
            prov = character_search(in_prog, [["R12"]], iter)
            if ['W3'] in in_prog[prov + 1:new_iter] or ['W4'] in in_prog[prov + 1:new_iter] or ['W5'] in

    in_prog[prov + 1:new_iter]:
    print('Потеряна фигурная скобка')
    return False
    # проанализируем следующую строчку


  start_next_str = character_search(in_prog, [["R4"]], new_iter) + 1
  print('1')
  end_next_str = character_search(in_prog, [["R4"]], start_next_str)
  # Есди в этой строчке есть else записываем и его
  if (['W4'] in in_prog[start_next_str:end_next_str]):
    new_iter = character_search(in_prog, [["R13"]], start_next_str + 1)
    prov = character_search(in_prog, [["R12"]], end_next_str)
    if ['W3'] in in_prog[prov + 1:new_iter] or ['W4'] in in_prog[prov + 1:new_iter] or [
      'W5'] in in_prog[
               prov + 1:new_iter]:
      print('Потеряна фигурная скобка')
      return False
    if Operators(in_prog[iter:new_iter + 1], 3):
      iter = character_search(in_prog, [["R4"]], new_iter) + 1
    else:
      return False
  # Если еслз не нашли, то проверяем if
  else:
    if Operators(in_prog[iter:new_iter + 1], 3):
      iter = character_search(in_prog, [["R4"]], new_iter) + 1
    else:
      return False
  # Если обнаружили while
  elif ["W5"] in in_prog[iter:new_iter]:
  # Ищем закрывающую фигурную скобку
  new_iter = character_search(in_prog, [["R13"]], new_iter)
  # Если мы её не нашли и упёрлись в конец программы
  if (new_iter == len(in_prog)):
    return False
  # }
  prov = character_search(in_prog, [["R12"]], iter)
  if ['W3'] in in_prog[prov + 1:new_iter] or ['W4'] in in_prog[prov + 1:new_iter] or ['W5'] in
    in_prog[prov + 1:new_iter]:
  print('Потеряна фигурная скобка')
  return False

  if Operators(in_prog[iter:new_iter + 1], 1):
    iter = character_search(in_prog, [["R4"]], new_iter) + 1
  else:
    return False

    # Если обнаружили function
  elif ["W17"] in in_prog[iter:new_iter]:
  # Ищем закрывающую фигурную скобку
  new_iter = character_search(in_prog, [["R13"]], new_iter)
  # Если мы её не нашли и упёрлись в конец программы
  if (new_iter == len(in_prog)):
    return False
  prov = character_search(in_prog, [["R12"]], iter)
  if ['W3'] in in_prog[prov + 1:new_iter] or ['W4'] in in_prog[prov + 1:new_iter] or ['W5'] in
    in_prog[prov + 1:new_iter]:
  print('Потеряна фигурная скобка')
  return False
  if Operators(in_prog[iter:new_iter + 1], 2):
    iter = character_search(in_prog, [["R4"]], new_iter) + 1
  else:
    return False

    # Если обнаружили оператор присваивания
  elif ["O12"] in in_prog[iter:new_iter]:
  if Operators(in_prog[iter:new_iter], 4):
    iter = character_search(in_prog, [["R4"]], new_iter) + 1
  else:
    return False
  else:
  print("Не обнаружен оператор")
  return False
  return True

  program = open_arr(task1_str)
  if Program(program):
    print('Good')
  else:
    print('bad')