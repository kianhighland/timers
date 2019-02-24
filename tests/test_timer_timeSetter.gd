extends "res://addons/gut/test.gd"

var data
var time_setter
var label

func setup():
  var Data = load("res://scripts/timer/data.gd")
  data = Data.new()
  var TimeSetter = load("res://scripts/timer/timeSetter.gd")
  time_setter = TimeSetter.new()
  time_setter.data = data

func test_setup():
  assert_ne(data, null, "data should not be null")
  assert_ne(time_setter, null, "time setter should not be null")
  assert_eq(time_setter.data, data, "we should have given time setter our data")
  data.set_denomination = data.Set_Denominations.Hour
  time_setter._pressed()
  assert_eq(data.set_denomination, data.Set_Denominations.Minutes_10)

func test_update_text():
  data.set_denomination = data.Set_Denominations.Hour
  time_setter.update_text()
  assert_eq(time_setter.text, "1Hour")
  data.set_denomination = data.Set_Denominations.Minutes_10
  time_setter.update_text()
  assert_eq(time_setter.text, "10Min")
  data.set_denomination = data.Set_Denominations.Minute
  time_setter.update_text()
  assert_eq(time_setter.text, "1Min")

func test_change_time():
  var Label = load("res://scripts/timer/label.gd")
  label = Label.new()
  time_setter.label = label
  label.data = data #We call show time in time setter so label has to have data
  assert_eq(time_setter.label, label)
  change_time_test(data.Set_Denominations.Hour, data.Bases.Doudecimal, 1, \
      3600, "it should have added an hour")
  change_time_test(data.Set_Denominations.Minutes_10, data.Bases.Doudecimal, 1, \
      3600, "it should have added 10 minutes")
  #TODO you know what? I don't care, I wrote this test and then it is gone.
func change_time_test(denomination, base, sign_constant, expected_time_change, \
      message, initial_time = 3600):
  #In these tests, the time always starts at an hour. If the function behaves
      #differently at different times, this test may not catch that
  label.time = 3600
  data.set_denomination = denomination
  data.base = base
  time_setter.change_time(sign_constant)
  assert_eq(label.time, initial_time + expected_time_change, message)
