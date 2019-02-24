#Lazy me is lazy
#That means no tests
extends Node2D

export(int) var scroll_speed
var file_edit = preload("res://scripts/main/loadFile.gd")
var start_time
var opening

func _init():
  start_time = OS.get_unix_time()
  opening = false

func _ready():
  file_edit.load_file(get_node("AddTimer"))
  get_tree().set_auto_accept_quit(false)
  get_node("LineEditParent/LineEdit").hide()
  var time = OS.get_unix_time()
  while true:
    if OS.get_unix_time() > time:
      break
  var timer = get_node("Timer")
  timer.wait_time = 1.07
  timer.start()
  yield(timer, "timeout")
  timer.wait_time = 1

func _input(event):
  if event is InputEventMouseButton:
    if event.button_index ==  BUTTON_WHEEL_UP:
      set_position(Vector2(get_position().x, get_position().y \
          + scroll_speed))
    elif event.button_index == BUTTON_WHEEL_DOWN:
      set_position(Vector2(get_position().x, get_position().y \
          - scroll_speed))
  if event.is_action_pressed("ui_home"):
    set_position(Vector2(0, 0))
  if event.is_action_pressed("save"):
    file_edit.write_file("res://times/",start_time, get_node("AddTimer").timers)
  if event.is_action_pressed("open"):
    get_node("LineEditParent/LineEdit").show()
    get_node("LineEditParent/LineEdit").text = ""
    opening = true
  elif event.is_action_pressed("ui_enter"):
    if opening:
      get_node("LineEditParent/LineEdit").hide()
      opening = false
      var save_file = get_node("LineEditParent/LineEdit").text
      if File.new().file_exists(save_file):
        get_node("RemoveAll").emit_signal("pressed")
        file_edit.load_save_file(save_file, get_node("AddTimer"))
      else:
        print("File \"" + save_file + "\" does not exist")

func _notification(what):
  if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
    file_edit.write_file("res://times/", start_time, \
        get_node("AddTimer").timers, true)
    get_tree().quit()
