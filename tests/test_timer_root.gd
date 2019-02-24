extends "res://addons/gut/test.gd"

var root

func setup():
  var Root = load("res://scripts/timer/root.gd")
  root = Root.new()

func test_setup():
  assert_ne(root.data, null, "root should have created their own data")
