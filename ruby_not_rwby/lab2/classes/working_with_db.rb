require_relative '../classes/student'
require_relative '../classes/student_short'
require 'sqlite3'
# Создание подключения к бд
db = SQLite3::Database.open 'student.db'
db.results_as_hash = true

#Создание таблицы student
# db.execute "CREATE TABLE IF NOT EXISTS student (
#   id          INTEGER PRIMARY KEY AUTOINCREMENT,
#   surname     TEXT NOT NULL,
#   name  	  TEXT NOT NULL,
#   patronymic  TEXT NOT NULL,
#   phone       TEXT NULL,
#   telegram    TEXT NULL,
#   email       TEXT NULL,
#   git         TEXT NULL)"

#вставка в таблицу
# db.execute "insert into student(surname, name, patronymic, phone, telegram, email, git) values
#   ('lupov', 'lupa', 'lupovich', NULL, NULL, NULL, NULL),
#   ('pupov', 'pupa', 'pupovich', '+79002112332', '@pupa', 'pupa@mail.ru', 'pupaProgramer'),
#   ('Ivanov', 'Ivan', 'Ivanich', NULL, NULL, NULL, NULL);"

# Выполнение select
# results = db.query( "SELECT * FROM student WHERE id = 0")

students = db.execute('SELECT * FROM student LIMIT ? OFFSET ?',1,0)
student_short_list = students.map{|student| StudentShort.student_init(Student.new(**student.transform_keys(&:to_sym)))}

puts (student_short_list)