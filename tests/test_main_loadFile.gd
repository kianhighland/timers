extends "res://addons/gut/test.gd"

var load_file

func setup():
  var LoadFile = load("res://scripts/main/loadFile.gd")
  load_file = LoadFile.new()
