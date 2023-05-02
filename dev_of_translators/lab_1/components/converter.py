class Converter:
  def __init__(self):
    self.keywords = {'if', 'else', 'while'}
    self.operators = {'(': 0, ')': 0, '=': 1, '+': 2, '-': 2, '*': 3, '/': 3}

  def translate_form_infix_to_postfix(self, tokens):
    stack = []
    result = []
    for token in tokens:
      # Если токен - число или переменная, добавляем его в результирующий список
      if token.isnumeric() or token.isalpha():
        result.append(token)
      # Если токен - оператор
      elif token in self.operators:
        # Переносим операторы с большим или равным приоритетом из стека в результирующий список
        while stack and stack[-1] != '(' and self.operators[token] <= self.operators[stack[-1]]:
          result.append(stack.pop())
        # Добавляем текущий оператор в стек
        stack.append(token)
      # Если токен - открывающая скобка, добавляем ее в стек
      elif token == '(':
        stack.append(token)
      # Если токен - закрывающая скобка
      elif token == ')':
        # Переносим операторы из стека в результирующий список, пока не встретим открывающую скобку
        while stack and stack[-1] != '(':
          result.append(stack.pop())
        # Удаляем открывающую скобку из стека
        if stack and stack[-1] == '(':
          stack.pop()
      # Если токен - ключевое слово, добавляем его в результирующий список
      elif token in self.keywords:
        result.append(token)

    # Переносим оставшиеся операторы из стека в результирующий список
    while stack:
      result.append(stack.pop())

    # Выводим результат
    return result

  def translate_from_postfix_to_infix(self, postfix):
    stack = []

    for token in postfix:
      if token.isnumeric() or token.isalpha():
        stack.append(token)
      elif token in {'+', '-', '*', '/', '%', '^', '<', '>', '<=', '>=', '==', 'and', 'or'}:
        # Извлекаем из стека соответствующее количество операндов
        op2 = stack.pop()
        op1 = stack.pop()
        # Выполняем операцию и помещаем результат в стек
        stack.append(f"({op1} {token} {op2})")
      # Если токен - ключевое слово
      elif token in {'if', 'else', 'while', 'print', 'and', 'or'}:
        # Если это print, извлекаем из стека соответствующее количество операндов
        if token == 'print':
          args = []
          while stack and stack[-1] != 'c':
            args.append(stack.pop())
          stack.pop()  # удаляем 'c' из стека
          args.reverse()  # восстанавливаем порядок аргументов
          stack.append(f"print({', '.join(args)})")
        # Если это if или while, извлекаем из стека условие
        else:
          condition = stack.pop()
          # Извлекаем из стека блок кода
          code = []
          while stack and stack[-1] != 'c':
            code.append(stack.pop())
          stack.pop()  # удаляем 'c' из стека
          # Объединяем блок кода в одну строку и добавляем в стек
          code.reverse()
          code_str = '\n    '.join(code)
          stack.append(f"{token} {condition}: \n    {code_str}")
    # Выводим результат
    result = stack.pop()
    return stack


