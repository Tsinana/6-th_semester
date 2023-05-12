class OPZ:
  # "a = 45 a = a + 10 / 2 if (a > 30) {i <- 0 while(i == 3){print(c(i,a,s,d,f))  i = i + 1\n  }} else {print(c('biba'))}"

  def __init__(self,expr):
    self.expr = expr

  def infix_to_postfix(self):
    stack = []
    output = []
    # prec = {'*': 2, '/': 2, '+': 1, '-': 1, '(': 0}
    funs = {'f': 2}
    vals = {'a': 0, 'b': 1,'с': 1,'d': 1,'i': 1,'j': 1,'y': 1,'x': 1,'z': 1}
    prec = {'**': 9,'*': 8, '/': 8, '+': 7,'-': 7,'<': 6,'>': 6,'==': 6,'!': 5,'&': 4, 'V': 3,'/n' : 2,'=': 2,'THEN': 1,';': 1,'ELSE': 1, ')': 1, ']': 1, ',': 1, '(': 0, '[': 0, 'АЭМ': 0, 'Ф': 0, 'IF': 0}
    aem_counter = 1
    f_counter = 1
    if_counter = 1
    do_counter = 1
    do_lvl = 1
    flag_f = 0
    flag_if = 0
    for token in self.expr:
      if token.isdigit() or token in vals:
        output.append(token)

      elif token == "{":
        while len(stack) != 0:
          output.append(stack.pop())

        output.append(f"{do_counter}_{do_lvl}_НП")
        do_lvl += 1
        do_counter += 1

      elif token == "}":
        while len(stack) != 0:
          output.append(stack.pop())

        output.append(f"{do_counter}_{do_lvl}_КО")
        do_lvl -= 1

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
      elif token == ')' and flag_if == 1:
        top_token = stack.pop()
        while top_token != "(":
          output.append(top_token)
          top_token = stack.pop()
        _ = output.pop()
        _ = output.pop()
        output.append(f"М{if_counter - 1}:")
        if_counter = 1

      elif token in funs:
        output.append(token)
        flag_f += 1
      elif token == '(' and flag_f == 1:
        stack.append(f"Ф")
        f_counter += 1
      elif token == ',' and flag_f == 1:
        top_token = stack.pop()
        f = f"Ф"
        while top_token != f:
          output.append(top_token)
          top_token = stack.pop()
        stack.append(top_token)
        f_counter += 1
      elif token == ')' and flag_f == 1:
        top_token = stack.pop()
        f = f"Ф"
        while top_token != f:
          output.append(top_token)
          top_token = stack.pop()
        output.append(f"{f_counter}Ф")
        f_counter = 1
        flag_f = 0

      elif token == '(':
        stack.append(token)
      elif token == ')':
        top_token = stack.pop()
        while top_token != '(':
          output.append(top_token)
          top_token = stack.pop()

      elif token == '[':
        aem_counter += 1
        stack.append(f"АЭМ")
      elif token == ',':
        top_token = stack.pop()
        aem = f"АЭМ"
        while top_token != aem:
          output.append(top_token)
          top_token = stack.pop()
        stack.append(top_token)
        aem_counter += 1
      elif token == ']':
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

  def eval_postfix(self):
    stack = []
    for token in self.expr:
      if token.isdigit():
        stack.append(int(token))
      else:
        operand2 = stack.pop()
        operand1 = stack.pop()
        result = self.do_math(token, operand1, operand2)
        stack.append(result)
    return stack.pop()


  def do_math(self, op, op1, op2):
    if op == "*":
      return op1 * op2
    elif op == "/":
      return op1 / op2
    elif op == "+":
      return op1 + op2
    else:
      return op1 - op2


