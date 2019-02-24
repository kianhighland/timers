extends "res://addons/gut/test.gd"

var label
var data

func setup():
  #assert_file_exists("res://scripts/timer/label.gd")
  var Label = load("res://scripts/timer/label.gd")
  #assert_ne(Label,null, "the class shouldn't be null")
  label = Label.new()
  #assert_file_exists("res://scripts/timer/data.gd")
  var Data = load("res://scripts/timer/data.gd")
  data = Data.new()
  #assert_ne(Data, null, "the class shouldn't be null")
  label.data = data
  #assert_eq(label.data, data, "we should have given object label our data")

func test_setup():
  assert_ne(label, null, "the class shouldn't be null")
  assert_eq(label.data, data, "we should have given object label our data")
  assert_eq(label.time, 0, "you start with 0 seconds")
  assert_eq(label.text, "0", "the text should say 0")

func test_incriment_time():
  label._reset_time()
  data.running = false
  label._increment_time()
  assert_eq(label.time, 0, "it should not have incrimented because running is "\
      + "false")
  assert_eq(label.text, "0", "text should say 0 because you start with 0 "\
      + "seconds")
  data.running = true
  label._increment_time()
  assert_eq(label.time, 1, "it should have incrimented from 0 to 1 because "\
      + "running is true")
  assert_eq(label.text, "1", "the text should be 1 because it's 1 second")

func test_set_time():
  label.time = 0
  assert_eq(label.time, 0, "time should be 0 because we set it that way")
  label.time = 5
  assert_eq(label.time, 5, "time should be 5 because we set it that way")

func test_reset_time():
  label.time = 5
  label._reset_time()
  assert_eq(label.time, 0, "time should be 0 because we reset the time")

func test_show_time_decimal():
  data.base = data.Bases.Decimal
  label.time = 11
  label.show_time()
  assert_eq(label.text, "11", "text should be 11 because it's 11 seconds")
  label.time = 63
  label.show_time()
  assert_eq(label.text, "1:03", "text should be 1:03 because it's 63 seconds")
  label.time = 3791
  label.show_time()
  assert_eq(label.text, "1:03:11", "text should be 1:03:11 because it's 3791 "\
      + "seconds")
  label.time = 3601
  label.show_time()
  assert_eq(label.text, "1:00:01", "that should be right")

func test_show_time_doudecimal():
  data.base = data.Bases.Doudecimal
  label.time = 11
  label.show_time()
  assert_eq(label.text, "B", "text should be B because it's 11 seconds")
  label.time = 63
  label.show_time()
  assert_eq(label.text, "1:03", "text should be 1:03 because it's 63 seconds")
  label.time = 3791
  label.show_time()
  assert_eq(label.text, "1:03:0B", "text should be 1:03:0B because")
  label.time = 3611
  label.show_time()
  assert_eq(label.text, "1:00:0B")

func test_positive_int_to_doudecimal():
  positive_int_to_doudecimal_test(0, "0")
  positive_int_to_doudecimal_test(1, "1")
  positive_int_to_doudecimal_test(11, "B")
  positive_int_to_doudecimal_test(12, "10")
  positive_int_to_doudecimal_test(32, "28")
  positive_int_to_doudecimal_test(192, "140")
  positive_int_to_doudecimal_test(2000, "11A8")

func positive_int_to_doudecimal_test(var number, var expected):
  print("number " + str(number))
  assert_eq(label.positive_int_to_doudecimal(number), expected)

func test_base_changed():
  label.time = 11
  data.base = data.Bases.Doudecimal
  assert_eq(label.text, "B", "11 is B")
  data._change_base()
  assert_eq(label.text, "11", "it's base 10")

