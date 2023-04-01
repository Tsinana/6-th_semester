class store_dicts:
  def char_range(self, cc1, cc2):
    """Generates the characters from `c1` to `c2`, inclusive."""
    for c in range(ord(cc1), ord(cc2) + 1):
      yield chr(c)


  def get_table_of_service_words(self):
    list_oper = ['if','print','else','c','ifelse','for','in','while','repeat','sum','len']
    return {list_oper[i]: i for i in range(len(list_oper))}


  def get_table_of_operations(self):
    list_oper = [ '+', '-', '*', '/', '%', '<', '>', '==', '!=', '<=', '>=']
    dict = {list_oper[i]: i for i in range(len(list_oper))}
    dict['='] = len(list_oper)
    dict['<-'] =  dict['=']
    return dict


  def get_table_of_separators(self):
    list_separ = [',','.',' ',';',':','[',']','{','}','(',')','\\n']
    return  {list_separ[i]: i for i in range(len(list_separ))}


  def get_table_of_chars(self):
    char_generator = self.char_range('a', 'z')
    dict_chars = {ch:1 for ch in char_generator}
    dict_digits = {digit: 2 for digit in range(0,11)}
    dict_chars.update(dict_digits)
    return dict_chars

  def get_all_compiled_dictionaries(self):
    dict_service_words = self.get_table_of_service_words()
    dict_operations = self.get_table_of_operations()
    dict_separators = self.get_table_of_separators()
    return{
      'W':dict_service_words,
      "I":{},
      "O":dict_operations,
      "R":dict_separators,
      "N":{},
      "C":{}
    }