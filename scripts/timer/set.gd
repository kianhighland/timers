extends Button

func _init():
  pass#self.connect("button_down", self, "pressed")

func _ready():
  get_node("../../SetButtons/CheckParent/Check").connect("button_down", \
    self, "check_pressed")
  check_pressed()

func _pressed():
  get_node("..").hide()
  get_node("../../SetButtons").show()

func check_pressed():
  get_node("..").show()
  get_node("../../SetButtons").hide()
