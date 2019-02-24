#some things in this class are untested. That's probably true for most classes
#But I know that this one is untested because of things like $Label.data = data
extends Node2D
var data

func _ready():
  $Label.data = data
  $MainButtons/Base.data = data
  if has_node("../Timer"):
    # now calls show_time because we will not be incrementing time anymore
    get_node("../Timer").connect("timeout", get_node("Label"),\
      "show_time")
  get_node("MainButtons/StartStop").data = data
  get_node("SetButtons/Denomination").data = data
    # get_node is relative to this node

func _init():
  var Data = load("res://scripts/timer/data.gd")
  data = Data.new()
