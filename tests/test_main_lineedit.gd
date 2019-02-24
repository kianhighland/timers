extends "res://addons/gut/test.gd"

var lineedit

func setup():
  var LineEdit = load("res://scripts/main/lineedit.gd")
  lineedit = LineEdit.new()

func test_setup():
  assert_eq(lineedit.label, null, "label starts an null")
