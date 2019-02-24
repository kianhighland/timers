extends "res://addons/gut/test.gd"

var add_timers

func setup():
  var AddTimers = load("res://scripts/main/addTimers.gd")
  add_timers = AddTimers.new()

func test_setup():
  assert_ne(add_timers, null, "object should not be null")

func test_move_timer():
  add_timers.timer_scene = add_timers.timer_packed_scene.instance()
  add_timers.set_position(Vector2(012, 523))
  add_timers.move_timer()
  assert_eq(add_timers.timer_scene.get_position(), Vector2(012, 523), \
      "it should have set it to it's position (which we set to that)")

func test_move():
  move_test(Vector2(126, 78), Vector2(314, 78), 600)

func move_test(position, expected, screen_size):
  add_timers.set_position(position)
  add_timers.move(screen_size)
  assert_eq(add_timers.get_position(), expected, "should have moved")
