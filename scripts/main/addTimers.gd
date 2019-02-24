#tests are anoying. They should make a thing that will test your code
  #automatically
extends Node2D

const gap_horz = 42 # the size of the gaps horizontally
const gap_vert = 42 # the size of the gaps vertically
const timer_width = 146 # the width (horizontal size) of the timers
const timer_height = 84
#var last_timer_position = Vector2(gap_horz + timer_width/2, gap_vert + \
#    timer_height/2)
var timer_packed_scene
var timer_scene
var timers = []

func _ready():
  get_node("Button").connect("button_down", self, "add_timer")
  var test_file = File.new()
  get_node("../RemoveAll").connect("pressed", self, "reset")

func _init():
  timer_packed_scene = preload("res://scenes/Timer.tscn")
    #A packed scene is the scene as a whole, like a class when we want an object
  reset()

#func add_timer():
#  add_timer("")

func move_timer():
  timer_scene.set_position(get_position())

func move(screen_width):
  if get_position().x + timer_width * 1.5 + gap_horz <= screen_width:
    set_position(Vector2(get_position().x + timer_width + gap_horz, \
         get_position().y))
  else:
    set_position(Vector2(gap_horz + timer_width/2, get_position().y \
        + gap_vert + timer_height))

func add_timer(name = "", base = null, time = 0):
  timer_scene = timer_packed_scene.instance()
  timer_scene.get_node("TimerName").text = name
  get_node("..").add_child(timer_scene)
  get_node("../RemoveAll").connect("pressed", timer_scene, "queue_free")
  timer_scene.data.time_before_start = time
  if base != null:
    timer_scene.data.base = base
  timers.append(timer_scene)
  move_timer()
  move(get_viewport().size.x)

func reset():
  set_position(Vector2(gap_horz + timer_width/2 , gap_vert + \
      timer_height/2))
  timers = []
