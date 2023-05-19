class OPZ:
  # "a = 45 a = a + 10 / 2 if (a > 30) {i <- 0 while(i == 3){print(c(i,a,s,d,f))  i = i + 1\n  }} else {print(c('biba'))}"

  def __init__(self,expr,dicts):
    self.expr = expr
    self.dicts = dicts

  def infix_to_postfix(self):
    stack = []
    output = []
    prec = {'**': 9,'*': 8, '/': 8,'+': 7,'-': 7,'<': 6,'>': 6,'==': 6,'!=': 6,'<=': 6, '>=': 6,'!': 5,'&': 4, 'V': 3,'/n' : 2,'=': 2,'<-': 2,'THEN': 1,';': 1,'ELSE': 1, ')': 1, ']': 1, ',': 1, '(': 0, '[': 0, 'АЭМ': 0, 'Ф': 0,'IF': 0,
            'O2': 8, 'O3': 8,'O0': 7,'O1': 7,'O5': 6,'O6': 6,'O7': 6,'O8': 6, 'O9': 6, 'O10': 6,'O11':2,'R3':1,'R9': 0}


    aem_counter = 1
    f_counter = 1
    if_counter = 1
    do_counter = 0
    tk_counter = 0
    do_lvl = 0
    flag_f = 0
    flag_if = 0
    output.append(f"{tk_counter}_НБ")
    for token in self.expr:
      if token.isdigit() or token[0] == 'N' or token[0] == 'I' or token[0] == 'C':
        output.append(token)

      elif token == ";" or token == 'R3':
        while len(stack) != 0:
          output.append(stack.pop())
        output.append(f"{tk_counter}_КБ")
        tk_counter+= 1
        output.append(f"{tk_counter}_НБ")


      elif token == "{" or token == 'R7':
        while len(stack) != 0:
          output.append(stack.pop())
        do_lvl += 1
        do_counter += 1
        output.append(f"{do_counter}_{do_lvl}_НП")
      elif token == "}" or token == 'R8':
        while len(stack) != 0:
          output.append(stack.pop())
        output.append(f"{do_counter}_{do_lvl}_КО")
        do_lvl -= 1
        do_counter -= 1


      elif token == 'IF':
        stack.append(token)
        flag_if = 1
      elif token == 'THEN':
        top_token = stack.pop()
        while top_token != "IF":
          output.append(top_token)
          top_token = stack.pop()
        stack.append(f"М{if_counter}")
        stack.append(top_token)
        output.append(f"М{if_counter}")
        output.append("УПЛ")
        if_counter += 1
      elif token == 'ELSE':
        top_token = stack.pop()
        while top_token != "IF":
          output.append(top_token)
          top_token = stack.pop()
        _ = stack.pop()
        stack.append(f"М{if_counter}")
        stack.append(top_token)
        output.append(f"М{if_counter}")
        output.append("БП")
        output.append(f"М{if_counter - 1}:")
        if_counter += 1
      elif (token == ')' or token == 'R10') and flag_if == 1:
        top_token = stack.pop()
        while top_token != "(" and top_token != "R9":
          output.append(top_token)
          top_token = stack.pop()
        _ = output.pop()
        _ = output.pop()
        output.append(f"М{if_counter - 1}:")
        if_counter = 1

      elif token[0] == 'W':
        output.append(token)
        flag_f = 1
      elif (token == '(' or token == "R9") and flag_f == 1:
        stack.append(f"Ф")
        f_counter += 1
      elif (token == ',' or token == "R0") and flag_f == 1:
        top_token = stack.pop()
        f = f"Ф"
        while top_token != f:
          output.append(top_token)
          top_token = stack.pop()
        stack.append(top_token)
        f_counter += 1
      elif (token == ')' or token == 'R10') and flag_f == 1:
        top_token = stack.pop()
        f = f"Ф"
        while top_token != f:
          output.append(top_token)
          top_token = stack.pop()
        output.append(f"{f_counter}Ф")
        f_counter = 1
        flag_f = 0

      elif token == '(' or token == 'R9':
        stack.append(token)
      elif token == ')' or token == 'R10':
        top_token = stack.pop()
        while top_token != '(' and top_token != 'R9':
          output.append(top_token)
          top_token = stack.pop()

      elif token == '[' or token == 'R5':
        aem_counter += 1
        stack.append(f"АЭМ")
      elif token == ',' or token == 'R0':
        top_token = stack.pop()
        aem = f"АЭМ"
        while top_token != aem:
          output.append(top_token)
          top_token = stack.pop()
        stack.append(top_token)
        aem_counter += 1
      elif token == ']' or token == 'R6':
        top_token = stack.pop()
        aem = f"АЭМ"
        while top_token != aem:
          output.append(top_token)
          top_token = stack.pop()
        output.append(f"{aem_counter}aem")
        aem_counter = 1

      else:
        while (len(stack) != 0) and (prec[stack[-1]] >= prec[token]):
          output.append(stack.pop())
        stack.append(token)

    while len(stack) != 0:
      output.append(stack.pop())
    return ' '.join(output)

