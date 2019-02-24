extends "res://addons/gut/test.gd"

var data

func setup():
  var Data = load("res://scripts/timer/data.gd")
  data = Data.new()

func test_setup():
  assert_ne(data, null, "it better not be null")
  assert_eq(data.base, data.Bases.Doudecimal, "we start in doudecimal")
  assert_eq(data.running, false, "starts not running")

func test_set_base():
  assert_eq(data.base, data.Bases.Doudecimal)
  data.base = data.Bases.Decimal
  assert_eq(data.base, data.Bases.Decimal)
  data.base = data.Bases.Doudecimal
  assert_eq(data.base, data.Bases.Doudecimal)
  data.base = data.Bases.Doudecimal
  assert_eq(data.base, data.Bases.Doudecimal)

func test_change_base():
  data.base = data.Bases.Doudecimal
  data._change_base()
  assert_eq(data.base, data.Bases.Decimal)
  data.base = data.Bases.Decimal
  data._change_base()
  assert_eq(data.base, data.Bases.Doudecimal)

func test_set_running():
  assert_eq(data.running, false)
  data.running = true
  assert_eq(data.running, true)
  data.running = false
  assert_false(data.running)
  data.running = false
  assert_false(data.running)

func test_change_running():
  data.running = false
  watch_signals(data)
  data.change_running()
  assert_signal_emitted(data, "start_stop")
  assert_true(data.running)
  data.base = true
  data.change_running()
  assert_false(data.running)

func test_cycle_set_denominations():
  data.set_denomination = data.Set_Denominations.Hour
  data.cycle_set_denomination()
  assert_eq(data.set_denomination, data.Set_Denominations.Minutes_10, \
    "hour goes to 10 minutes")
  data.set_denomination = data.Set_Denominations.Minutes_10
  data.cycle_set_denomination()
  assert_eq(data.set_denomination, data.Set_Denominations.Minute, \
    "10 minutes goes to minute")
  data.set_denomination = data.Set_Denominations.Minute
  data.cycle_set_denomination()
  assert_eq(data.set_denomination, data.Set_Denominations.Hour, \
    "minute goes to hour")
