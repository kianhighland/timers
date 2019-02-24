signal base_changed
signal start_stop
enum Bases {Decimal, Doudecimal}
enum Set_Denominations {Hour, Minutes_10, Minute}
var base setget set_base
var running setget set_running
var set_denomination
var time_before_start
var unix_time_at_start

func _init():
  base = Bases.Doudecimal
  running = false
  reset_time()

func set_base(baseIn):
  base = baseIn
  emit_signal("base_changed")

func _change_base():
  if(base == Bases.Doudecimal):
    set_base(Bases.Decimal)
  else:
    set_base(Bases.Doudecimal)

func set_running(runningIn):
  if running == runningIn:
    print("Hey Look ---- running is equal to running in. data.gd")
  else:
    running = runningIn
    if running:
      unix_time_at_start = OS.get_unix_time()
    else:
      time_before_start += OS.get_unix_time() - unix_time_at_start
    emit_signal("start_stop")

func change_running():
  set_running(!running)

func cycle_set_denomination():
  if set_denomination == Set_Denominations.Hour:
    set_denomination = Set_Denominations.Minutes_10
  elif set_denomination == Set_Denominations.Minutes_10:
    set_denomination = Set_Denominations.Minute
  else:
    set_denomination = Set_Denominations.Hour

func reset_time():
  time_before_start = 0
  unix_time_at_start = OS.get_unix_time()

func get_time():
  if running:
    return time_before_start + OS.get_unix_time() - unix_time_at_start
  else:
    return time_before_start
