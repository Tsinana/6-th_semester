#!/usr/bin/env ruby

require 'fox16'

include Fox

class TabBookWindow < FXMainWindow

  def initialize(app)
    super(app, "Tab Book Test", :opts => DECOR_ALL, :width => 600, :height => 400)

    # Tooltip
    FXToolTip.new(getApp())

    # Contents
    contents = FXHorizontalFrame.new(self,
      LAYOUT_SIDE_TOP|FRAME_NONE|LAYOUT_FILL_X|LAYOUT_FILL_Y|PACK_UNIFORM_WIDTH)
  
    # Switcher
    @tabbook = FXTabBook.new(contents,:opts => LAYOUT_FILL_X|LAYOUT_FILL_Y|LAYOUT_RIGHT)
  
    # First item is a list
    @tab1 = FXTabItem.new(@tabbook, "&Students", nil)
    listframe = FXVerticalFrame.new(@tabbook, FRAME_THICK|FRAME_RAISED)
    # header
    header_frame = FXHorizontalFrame.new(listframe, FRAME_THICK|LAYOUT_FILL_X|LAYOUT_TOP)
    header_label = FXLabel.new(header_frame, "My App Header", nil, LAYOUT_FILL_X|JUSTIFY_CENTER_X)
    
    # footer
    footer = FXHorizontalFrame.new(listframe, FRAME_THICK|LAYOUT_FILL_X|LAYOUT_BOTTOM)
    footer_label = FXLabel.new(footer, "footer Content", nil, LAYOUT_FILL_X|JUSTIFY_CENTER_X)

    # nav & main
    section_frame = FXHorizontalFrame.new(listframe, FRAME_THICK|LAYOUT_TOP|LAYOUT_FILL)

    # nav
    nav_frame = FXVerticalFrame.new(section_frame, FRAME_THICK|LAYOUT_FILL_Y|LAYOUT_LEFT)
    nav_label = FXLabel.new(nav_frame, "Navigation", nil, LAYOUT_FILL_X|JUSTIFY_CENTER_X)

    # main
    main_frame = FXVerticalFrame.new(section_frame, FRAME_THICK|LAYOUT_FILL_X|LAYOUT_FILL_Y)
    main_label = FXLabel.new(main_frame, "Main Content", nil, LAYOUT_FILL_X|JUSTIFY_CENTER_X)

      
    # Second item is a file list
    @tab2 = FXTabItem.new(@tabbook, "F&ile List", nil)
    @fileframe = FXHorizontalFrame.new(@tabbook, FRAME_THICK|FRAME_RAISED)
    filelist = FXFileList.new(@fileframe, :opts => ICONLIST_EXTENDEDSELECT|LAYOUT_FILL_X|LAYOUT_FILL_Y)
    
    # Third item is a directory list
    @tab3 = FXTabItem.new(@tabbook, "&Tree List", nil)
    dirframe = FXHorizontalFrame.new(@tabbook, FRAME_THICK|FRAME_RAISED)
    dirlist = FXDirList.new(dirframe,
      :opts => DIRLIST_SHOWFILES|TREELIST_SHOWS_LINES|TREELIST_SHOWS_BOXES|LAYOUT_FILL_X|LAYOUT_FILL_Y)
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  app = FXApp.new("TabBook", "FoxTest")

  TabBookWindow.new(app)

  app.create

  app.run
end

