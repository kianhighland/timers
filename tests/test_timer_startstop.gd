extends "res://addons/gut/test.gd"

var startstop
var data

func setup():
  var StartStop = load("res://scripts/timer/startstop.gd")
  startstop = StartStop.new()
  var Data = load("res://scripts/timer/data.gd")
  data = Data.new()
  startstop.data = data

func test_setup():
  assert_ne(startstop, null, "should not be null")
  assert_ne(data, null, "should not be null")
  assert_eq(startstop.text, "Start", "should start saying start")

func test_running_text():
  assert_eq(startstop.running_text(true), "Stop", "running means says Stop")
  assert_eq(startstop.running_text(false), "Start", "not running says Start")

func test_running_changed():
  data.running = false
  assert_eq(startstop.text, "Start", "not running says start")
  data.running = true
  assert_eq(startstop.text, "Stop", "running says stop")
