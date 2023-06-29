require_relative './classes/students_view'
require_relative './classes/students_list_controler'
require_relative './classes/data&lists/student_list/students_list_file_adapter'
require_relative './classes/data&lists/student_list/students_list_file'
require_relative  './classes/data&lists/student_list/students_list_json'
require_relative  './classes/data&lists/student_list/students_list_db'


begin
 
  if __FILE__ == $0
    #file
    students_list_file = StudentListFile.new(StudentListJson.new())
    dataFile = StudentListFileAdapter.new(students_list_file,"C:\\Users\\Tsinana\\GitHub\\6-th_semester\\ruby_not_rwby\\lab2\\data\\data_file.json")
    #db
    students_list_db = StudentListDB.new()
    controller = StudentsListControler.new(students_list_db) 
    FXApp.new do |app| 
      view = Students_view.new(app)
      controller.set_view view
      view.set_controller controller
      view.get_controller.refresh_data

      controller.get_data_list.subscribe(view) 
      controller.get_data_list.notify
      app.create 
      app.run 
    end 
  end
	
end