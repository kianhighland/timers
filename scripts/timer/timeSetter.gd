extends Button

var data setget construct
var label

func _init():
  pass

func construct(dataIn):
  data = dataIn
  update_text()

func _ready():
  label = get_node("../../Label")
  get_node("../Add").connect("button_up", self, "change_time", [1])
  get_node("../Subtract").connect("button_up", self, "change_time", [-1])

func _pressed():
  data.cycle_set_denomination()
  update_text()

func update_text():
  if data.set_denomination == data.Set_Denominations.Hour:
    text = "1Hour"
  elif data.set_denomination == data.Set_Denominations.Minutes_10:
    text = "10Min"
  else:
    text = "1Min"

func change_time(sign_constant):
  if data.set_denomination == data.Set_Denominations.Hour:
    data.time_before_start = data.time_before_start + sign_constant * \
        label.seconds_in_minute * label.minutes_in_hour
  elif data.set_denomination == data.Set_Denominations.Minutes_10:
    if data.base == data.Bases.Decimal:
      data.time_before_start = data.time_before_start + sign_constant * 10 * \
          label.seconds_in_minute
    elif data.base == data.Bases.Doudecimal:
      data.time_before_start = data.time_before_start + sign_constant * 12 * \
          label.seconds_in_minute
  else:
    data.time_before_start = data.time_before_start + sign_constant * label.seconds_in_minute
  if data.get_time() < 0:
    data.reset_time()
  label.show_time()
