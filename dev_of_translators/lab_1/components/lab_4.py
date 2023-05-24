class lab4:
  def __init__(self, expr, dicts):
    self.expr = expr
    self.dicts = dicts

  def SCAN(self):
    self.NXTSYMB = self.expr.pop()

  def ERROR(self):
    raise ValueError("Ошибка!")

  def PROGRAM(self):
    self.SCAN()
    if self.NXTSYMB != 'PROC':
      self.ERROR()
    self.SCAN()
    if self.NXTSYMB != 'MAIN':
      self.ERROR()
    if self.NXTSYMB != ';':
      self.ERROR()
    self.SCAN()
    self.TEXT()
    self.SCAN()
    if self.NXTSYMB != 'END':
      self.ERROR()
    self.SCAN()
    if self.NXTSYMB != '.':
      self.ERROR()

  def TEXT(self):
    while self.NXTSYMB != ';':
      if self.NXTSYMB == 'def':
        self.PROCED()
      else:
        self.LINE()

  def PROCED(self):
    self.SCAN()
    if not self.IDENT():
      self.ERROR()
    self.SCAN()
    if self.NXTSYMB != ';':
      self.ERROR()
    self.SCAN()
    while self.NXTSYMB != 'END':
      self.LINE()
      self.SCAN()
    self.SCAN()
    if self.NXTSYMB != ';':
      self.ERROR()

  def LINE(self):  #
    if self.NXTSYMB[0] == "I":  #
      self.DECLARE()  #
    else:
      self.SEP_OPER()

  def DECLARE(self):
    self.SCAN()
    if not self.NXTSYMB[0] == 'I':
      self.ERROR()
    self.SCAN()
    while self.NXTSYMB == ",":
      self.SCAN()
      if not self.IDENT():
        self.ERROR()
      self.SCAN()
    if self.NXTSYMB != "DEC":
      self.ERROR()
    self.SCAN()
    if self.NXTSYMB != "FIXED":
      self.ERROR()
    self.SCAN()
    if self.NXTSYMB != ";":
      self.ERROR()
    self.SCAN()

  def SEP_OPER(self):
    if self.NXTSYMB == 'IF' or self.NXTSYMB == 'GOTO':
      self.OPERATOR()
    else:
      if not self.IDENT():
        self.ERROR()

      self.SCAN()

      if self.NXTSYMB == ':':
        self.SCAN()
        self.OPERATOR()
      elif self.NXTSYMB == ':=':
        self.SCAN()
        self.EXPRESSION()
      else:
        self.ERROR()

  def OPERATOR(self):
    if self.NXTSYMB == 'IF':
      self.IF_OPER()
    elif self.NXTSYMB == 'GOTO':
      self.SCAN()
      if not self.IDENT():
        self.ERROR()
    else:
      self.IDENT()
      if self.NXTSYMB != ':=':
        self.ERROR()
      else:
        self.SCAN()
        self.EXPRESSION()

  def IF_OPER(self):
    self.SCAN()
    self.CONDITION()
    if self.NXTSYMB != 'THEN':
      self.ERROR()
    else:
      self.SCAN()
      self.OPERATOR()

  def CONDITION(self):
    self.EXPRESSION()
    if self.NXTSYMB != '>' and self.NXTSYMB != '<':
      self.ERROR()
    self.SCAN()
    self.EXPRESSION()

  def EXPRESSION(self):
    self.TERM()
    self.SCAN()
    while self.NXTSYMB == '+':
      self.SCAN()

  def TERM(self):
    self.FACTOR()
    while self.NXTSYMB == '*':
      self.SCAN()
      self.FACTOR()
ф
  def FACTOR(self):
    if self.NXTSYMB == '(':
      self.SCAN()
      self.EXPRESSION()
      if self.NXTSYMB != ')':
        self.ERROR()
    else:
      self.SCAN()

  def ARGUMENT(self):
    if not self.DIGIT(self.NXTSYMB):
      if not self.IDENT():
        self.ERROR()
    self.SCAN()

  def IDENT(self):
    if not self.DIGIT(self.NXTSYMB):
      return False
    return True

  def WORD(self, SYMB):
    if 'Z' >= SYMB >= 'A':
      return True
    return False

  def DIGIT(self, SYMB):
    if SYMB.isDigit():
      return True
    return False