extends Button
var data setget construct

func _ready():
  _init()

func _init():
  text = "12"

func construct(dataIn):
  data = dataIn
  data.connect("base_changed", self, "base_changed")
  self.connect("button_up", data, "_change_base")

func base_changed():
  text = base_number(data.base)

func base_number(base):
  if(base == data.Bases.Decimal):
    return "10"
  else:
    return "12"
