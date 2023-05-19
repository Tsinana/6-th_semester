class infix:
  def __init__(self,expr,dicts):
    self.expr = expr
    self.dicts = dicts

  def start(self):
    stack = []
    output = []
    prec = {'**': 9, '*': 8, '/': 8, '+': 7, '-': 7, '<': 6, '>': 6, '==': 6, '!=': 6, '<=': 6, '>=': 6, '!': 5, '&': 4,
            'V': 3, '/n': 2, '=': 2, '<-': 2, 'THEN': 1, ';': 1, 'ELSE': 1, ')': 1, ']': 1, ',': 1, '(': 0, '[': 0,
            'АЭМ': 0, 'Ф': 0, 'IF': 0,
            'O2': 8, 'O3': 8, 'O0': 7, 'O1': 7, 'O5': 6, 'O6': 6, 'O7': 6, 'O8': 6, 'O9': 6, 'O10': 6, 'O11': 2,
            'R3': 1, 'R9': 0}


    for token in self.expr:
      if token.isdigit() or token[0] == 'N' or token[0] == 'I' or token[0] == 'C':
        stack.append(token)

      elif token == 'W3':
        output.append(token)

      elif token[0] == 'W':
        stack.append(token)

      elif token == "=" or token == 'O11':
        f_st = stack.pop()
        sec = stack.pop()
        stack.append(f" {sec} {token} {f_st} ")

      elif token[0].isdigit():
        if token[1] == 'Ф':
          i = int(token[0])
          while i != 2:
            f_st = stack.pop()
            sec = stack.pop()
            stack.append(f" {sec} , {f_st} ")
            i -= 1
          f_st = stack.pop()
          sec = stack.pop()
          stack.append(f"{sec} ( {f_st} ) ")
          if stack[0][0] == 'W':
            while len(stack) != 0:
              output.append(stack.pop())
        elif token[2] == 'Н' and token[3] == 'Б':
          _ = 1
        elif token[2] == 'К' and token[3] == 'Б':
          while len(stack) != 0:
            output.append(stack.pop())
          output.append('\n')
        elif token[4] == 'Н':
          output.append(' { ')
          output.append('\n')
        elif token[4] == 'К':
          output.append(' } ')

      else:
        f_st = stack.pop()
        sec = stack.pop()
        stack.append(f" ( {sec} {token} {f_st} ) ")

    while len(stack) != 0:
      output.append(stack.pop())

    php_dict = self.get_table_of_service_words()
    ans_out = ""
    for line in output:
      if line == '\n':
        ans_out += '\n'
      for el in line.split():
        num =  "".join(list(el)[1:])
        if el[0] == 'I':
          ans_out += f"${self.get_key(self.dicts['I'], num)}"
        elif el[0] == 'N' or el[0] == 'O':
          ans_out += f"{self.get_key(self.dicts[el[0]],num)}"
        elif el[0] == 'C':
          ans_out += f"\'{self.get_key(self.dicts[el[0]], num)}\'"
        elif el[0] == 'W':
          ans_out += f"{self.get_key(php_dict, num)}"

        else:
          ans_out+=el

    print(ans_out)

  def get_table_of_service_words(self):
    list_oper = ['/n','if','print_r','else','array','elifel','for','in','while','sum','length']
    return {list_oper[i]: i for i in range(len(list_oper))}

  def get_key(self, d, value):
    for k, v in d.items():
      if int(v) == int(value):
        return k