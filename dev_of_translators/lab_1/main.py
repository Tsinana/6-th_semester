from components.converter import Converter
from components.postfix import OPZ
from components.store_dictrs import store_dicts
import re

def replace_data(txt,dict,nameDict):
  for k,v in dict.items():
    txt = txt.replace(v,nameDict+k)
  return txt


def preparation_text(txt):
  return txt.replace(' ','')


def push_code(case,string,dicts,code_dict):
  if dicts[code_dict].get(string) != None:
    case+=code_dict + str(dicts[code_dict][string]) + ' '
  else:
    if 'W' == code_dict:
      code_dict = 'I'
      if dicts[code_dict].get(string) != None:
        case += code_dict + str(dicts[code_dict][string]) + ' '
        return case
    elif 'R' == code_dict:
      code_dict = 'N'
      if dicts[code_dict].get(string) != None:
        case += code_dict + str(dicts[code_dict][string]) + ' '
        return case
    dicts[code_dict][string] = len(dicts[code_dict])
    case +=code_dict + str(dicts[code_dict][string]) + ' '
  return case




def treat_text(txt,dicts):
  txt = preparation_text(txt)
  case = ''
  string_keeper = ''
  # 0 = б
  # 1 = бц
  # 2 = ц1
  # 3 = ц2
  # 4 = delete
  # 5 = nil
  # 6 = .ц
  # 7 = C
  state_keeper = 5
  i =0
  while i  < len(txt):
    char = txt[i]
    if  state_keeper == 0:
      if 'a' <= char <= 'z':
        string_keeper += char
      elif '0' <= char <= '9':
        state_keeper = 1
        string_keeper += char
      else:
        case = push_code(case,string_keeper,dicts,'W')
        string_keeper = ''
        state_keeper = 5
        i-=1

    elif state_keeper == 1:
      if 'a' <= char <= 'z' or '0' <= char <= '9':
        string_keeper += char
      else:
        case = push_code(case, string_keeper, dicts, 'I')
        string_keeper = ''
        state_keeper = 5
        i -= 1

    elif state_keeper == 2:
      if '0' <= char <= '9':
        string_keeper += char
      elif char == '.':
        state_keeper = 3
        string_keeper += char
      else:
        case = push_code(case, string_keeper, dicts, 'R')
        string_keeper = ''
        state_keeper = 5
        i -= 1

    elif state_keeper == 3:
      if '0' <= char <= '9':
        string_keeper += char
      else:
        case = push_code(case, string_keeper, dicts, 'R')
        string_keeper = ''
        state_keeper = 5
        i -= 1

    elif state_keeper == 4:
      if char == '\n':
        string_keeper = ''
        state_keeper = 5

    elif state_keeper == 6:
      if '0' <= char <= '9':
        state_keeper = 3
        string_keeper += char
      else:
        case = push_code(case, string_keeper, dicts, 'R')
        string_keeper = ''
        state_keeper = 5
        i -= 1

    elif state_keeper == 7:
      if char == '\'' or  char == '\"':
        case = push_code(case, string_keeper, dicts, 'C')
        string_keeper = ''
        state_keeper = 5
      else:
        string_keeper += char

    else:
        if 'a' <= char <= 'z':
          state_keeper = 0
          string_keeper += char

        elif '0' <= char <= '9':
          state_keeper = 2
          string_keeper += char

        elif char == '.':
          state_keeper = 6
          string_keeper += char

        elif char == '#':
          state_keeper = 4
          string_keeper += char

        elif char == '\'' or char == '\"':
          state_keeper = 7

        else:
          if dicts['O'].get(char) != None:
            case = push_code(case, char, dicts, 'O')
          elif dicts['R'].get(char) != None:
            case = push_code(case, char, dicts, 'R')
    i+=1
  return case


if __name__ == '__main__':
  # SD = store_dicts()
  # dicts = SD.get_all_compiled_dictionaries()
  # with open("program_r.r", "r") as f:
  #   data = f.read()

  # with open("prog_in_code.txt", "w") as f:
  #   print(treat_text(data,dicts), file=f)

  expr = input("Введите выражение в инфиксной форме: ").split()
  opz = OPZ(expr)
  postfix_expr = opz.infix_to_postfix()
  print("Выражение в ОПЗ: ", postfix_expr)

  # expr = input("Введите выражение в обратной польской записи: ").split()
  # opz = OPZ(postfix_expr.split())
  # result = opz.eval_postfix()
  # print("Результат вычислений:", result)
  # expression = "a = 45 \na = a + 10 / 2\nif (a > 30) {\n  i <- 0\n  while(i == 3){\n    print(c(i,a,s,d,f))\n    i = i + 1\n  }\n} else {\n  print(c('biba'))\n}"
  # tokens = re.findall(r'\d+\.?\d*|[A-Za-z]+|\S', expression)
  #
  # convector = Converter()
  # # result = convector.translate_form_infix_to_postfix(tokens)
  #
  # tokens = ['a', '45', '=', 'a', '10', '2', '/', '+', 'a', '30', '>', 'if', 'i', '0', '<-', 'i', '3', '==', 'while', 'i', 'a', 's', 'd', 'f', 'print', 'c']
  #
  # result = convector.translate_from_postfix_to_infix(tokens)
  # print(result)