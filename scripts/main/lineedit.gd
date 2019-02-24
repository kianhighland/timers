extends LineEdit
#warning, this class is severly untested. It loads things and stuff and I'm too
  #lazy to try to do integrated testing. Don't know how. I'm just lazy that way

var label setget set_label

func _ready():
  #get_node("..").hide()
  #print("get_node(\"..\").hide()")
  get_node("../CancelButton").connect("button_down", self, "cancel_set_name")
  get_node("../OkayButton").connect("button_down", self, "set_name")

func _init():
  label = null

func _process(delta):
  if(Input.is_action_pressed("ui_cancel")):
    cancel_set_name()
  elif(Input.is_action_pressed("ui_enter")):
    set_name()

func set_label(labelIn):
  if(label == null):
    label = labelIn
    print(label)
    get_node("..").show()
    print("get_node(\"..\").show()")

func set_name():
  print("okayhit")
  print(label)
  if(label != null):
    print("okay")
    label.text = text
    label = null
    get_node("..").hide()

func cancel_set_name():
  label = null
  get_node("..").hide()
