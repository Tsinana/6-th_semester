require_relative "controller_add_student"
require_relative "./student/student"
require 'fox16'

include Fox

class ModalWinAddStudent < FXMainWindow
  def initialize(app)
    super(app, "My App", nil, nil, DECOR_ALL, 0, 0, 256, 256)
  
    @successful_color = FXRGB(153, 255, 153)
    @valide_color = FXRGB(0, 255, 102)
    @default_color = FXRGB(100, 100, 100)
    @unvalide_color = FXRGB(255, 102, 51)

    self.window_filling
  end

  def set_controller(controller)
    self.controller = controller
  end

  def get_controller
    self.controller
  end

  def create 
    super
    show(PLACEMENT_SCREEN) 
  end

  def close_win
    close
  end

  private
  def window_filling
    self.create_input_fields
    FXHorizontalSeparator.new(self,
      LAYOUT_SIDE_TOP|SEPARATOR_GROOVE|LAYOUT_FILL_X)
    self.create_buttons
    # @btn_edit.enabled = true
  end

  def create_input_fields
    @add_btn_check = []
    if_frame = FXHorizontalFrame.new(self, LAYOUT_FILL_X|LAYOUT_TOP)
    @matrix = FXMatrix.new(if_frame, 2, MATRIX_BY_COLUMNS|LAYOUT_FILL_X)

    FXLabel.new(@matrix, "surname*:")
    @tf_surname = FXTextField.new(@matrix, 20)
    @tf_surname.connect(SEL_COMMAND, method(:onFullName))
    @add_btn_check << @tf_surname.object_id

    FXLabel.new(@matrix, "name*:")
    @tf_name = FXTextField.new(@matrix, 20)
    @tf_name.connect(SEL_COMMAND, method(:onFullName))
    @add_btn_check << @tf_name.object_id

    FXLabel.new(@matrix, "patronymic*:")
    @tf_patronymic = FXTextField.new(@matrix, 20)
    @tf_patronymic.connect(SEL_COMMAND, method(:onFullName))
    @add_btn_check << @tf_patronymic.object_id

    FXLabel.new(@matrix, "phone:")
    @tf_phone = FXTextField.new(@matrix, 20)
    default_color = @tf_phone.borderColor # !
    @tf_phone.connect(SEL_COMMAND) do |sender, sel, data|
      self.onInfo(sender, sel, data, Student.validate_phone(data))
    end
      
    FXLabel.new(@matrix, "telegram:")
    @tf_telegram = FXTextField.new(@matrix, 20)
    @tf_telegram.connect(SEL_COMMAND) do |sender, sel, data|
      self.onInfo(sender, sel, data, Student.validate_telegram(data))
    end

    FXLabel.new(@matrix, "email:")
    @tf_email = FXTextField.new(@matrix, 20)
    @tf_email.connect(SEL_COMMAND) do |sender, sel, data|
      self.onInfo(sender, sel, data, Student.validate_email(data))
    end

    FXLabel.new(@matrix, "git:")
    @tf_git = FXTextField.new(@matrix, 20)
    @tf_git.connect(SEL_COMMAND) do |sender, sel, data|
      self.onInfo(sender, sel, data, Student.validate_git(data))
    end
  end

  def onFullName(sender, sel, data)
    obj_id = sender.object_id
    if Student.validate_full_name data
      sender.borderColor = @valide_color
      @add_btn_check.delete obj_id
    else
      sender.borderColor = @unvalide_color
      @add_btn_check |= [obj_id]
    end
    self.add_btn_enabled
  end

  def onInfo(sender, sel, data, valide)
    obj_id = sender.object_id
    if data == ""
      @add_btn_check.delete obj_id
      sender.borderColor = @default_color
    elsif valide
      @add_btn_check.delete obj_id
      sender.borderColor = @valide_color = FXRGB(50, 205, 50)
    else
      sender.borderColor = @unvalide_color
      @add_btn_check |= [obj_id]
    end
    self.add_btn_enabled
  end

  def add_btn_enabled
    if @add_btn_check.length == 0 
      @btn_ok.enabled = true
    else
      @btn_ok.enabled = false
    end
  end

  def get_data_from_textfeild
    {"id"=>0,"surname"=> @tf_surname.text,"name"=>@tf_name.text,"patronymic"=>@tf_patronymic.text,"phone"=>@tf_phone.text, "telegram"=>@tf_telegram.text,"email"=>@tf_email.text,"git"=>@tf_git.text}
  end

  def create_buttons
    b_frame = FXHorizontalFrame.new(self, LAYOUT_FILL_X|LAYOUT_TOP)
    @btn_cancel = FXButton.new(b_frame,
      "Cancel",
      :opts => FRAME_RAISED|FRAME_THICK|LAYOUT_CENTER_X|LAYOUT_CENTER_Y|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT,
      :width => 80, :height => 30)
    @btn_ok = FXButton.new(b_frame,
      "Add",
      :opts => FRAME_RAISED|FRAME_THICK|LAYOUT_CENTER_X|LAYOUT_CENTER_Y|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT,
      :width => 80, :height => 30)

    @btn_ok.connect(SEL_COMMAND) do |sender, sel, data|
      self.controller.add_student(self.get_data_from_textfeild)
    end
    @btn_cancel.connect(SEL_COMMAND) do |sender, sel, data|
      close
    end

    @btn_cancel.backColor = FXRGB(180, 200, 230)
    @btn_ok.backColor = FXRGB(180, 200, 230)
    @btn_ok.enabled = false
  end

    attr_accessor :controller
end
