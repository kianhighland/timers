extends "res://addons/gut/test.gd"

var base
var data

func setup():
  var Base = load("res://scripts/timer/base.gd")
  base = Base.new()
  var Data = load("res://scripts/timer/data.gd")
  data = Data.new()
  base.data = data

func test_setup():
  assert_ne(base, null, "should not be null")
  assert_ne(data, null, "should not be null")
  assert_eq(base.text, "12", "starts in base 12")

func test_update_text():
  assert_eq(base.base_number(data.Bases.Doudecimal), "12", "doudecimal is 12")
  assert_eq(base.base_number(data.Bases.Decimal), "10", "decimal is 10")

func test_base_changed(): # warning, this tests two things. Nah, it's fine
  data.base = data.Bases.Doudecimal
  assert_eq(base.text, "12", "it's doudecimal")
  data.base = data.Bases.Decimal
  assert_eq(base.text, "10", "it's decimal")
