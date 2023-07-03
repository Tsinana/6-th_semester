require_relative './classes/students_view'
require_relative './classes/students_list_controler'
require_relative './classes/data&lists/student_list/students_list_file_adapter'
require_relative './classes/data&lists/student_list/students_list_file'
require_relative  './classes/data&lists/student_list/students_list_json'
require_relative  './classes/data&lists/student_list/students_list_db'
require_relative "./classes/controller_add_student"
require_relative "./classes/modal_win_add_student"


begin
 
  if __FILE__ == $0

    FXApp.new do |app| 
      controller = StudentsListControler.new() 
      model = DataListStudentShort.new([])
      view = Students_view.new(app) 
      controller.set_model model
      controller.get_model.subscribe(view)
      view.set_controller controller

      view.get_controller.refresh_data
      controller.get_model.notify
      app.create 
      app.run 
    end 
  end
	
end