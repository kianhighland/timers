extends Button

var data setget construct

func _init():
  text = "Start"

func construct(dataIn):
  data = dataIn
  data.connect("start_stop", self, "set_running_text")
    #connects the signal on data "start_stop" to the function on this class
      # "set_running_text"
  self.connect("button_up", data, "change_running")

static func running_text(running):
  if(running):
    return "Stop"
  else:
    return "Start"

func set_running_text():
  text = running_text(data.running)
