extends Label
const seconds_in_minute = 60
const minutes_in_hour = 60
#var time
var saved_time
var data setget construct

func _ready():
  #print(get_tree().get_root().get_node("Root").get_node(hhhh)
  get_node("../SetButtons/Reset").connect("button_up", self, "_reset_time")
    #to get the root node, you have to do /root/<root node name>

func _init():
  pass

func construct(dataIn):
  data = dataIn
  data.connect("base_changed", self, "show_time")
  show_time()

#func _increment_time():
  #if(data.running):
    #time += 1
    #show_time()

func _reset_time():
  data.reset_time()
  show_time()

func show_time():
  if data == null:
    return
  var time = data.get_time()
  var hours = floor(time / (seconds_in_minute * minutes_in_hour))
  var time_left = time - hours*seconds_in_minute*minutes_in_hour
  var minutes = floor(time_left / seconds_in_minute)
  var seconds = time_left - minutes * seconds_in_minute
  var seconds_text
  var minutes_text
  var hours_text
  if(data.base == data.Bases.Decimal):
    seconds_text = str(seconds)
  else:
    seconds_text = positive_int_to_doudecimal(seconds)
  if(minutes > 0 || hours > 0):
    if(data.base == data.Bases.Decimal):
      minutes_text = str(minutes)
      if(seconds < 10):
        seconds_text = "0" + seconds_text
    else:
      minutes_text = positive_int_to_doudecimal(minutes)
      if(seconds < 12):
        seconds_text = "0" + seconds_text
  else:
    text = seconds_text
    return
  if(hours > 0):
    if(data.base == data.Bases.Decimal):
      hours_text = str(hours)
      if(minutes < 10):
        minutes_text = "0" + minutes_text
    else:
      hours_text = positive_int_to_doudecimal(hours)
      if(minutes < 12):
        minutes_text = "0" + minutes_text
  else:
    text = minutes_text + ":" + seconds_text
    return
  text = hours_text + ":" + minutes_text + ":" + seconds_text


static func positive_int_to_doudecimal(var number):
  var i = 1
  var string = ""
  number = int(number)
  if(number <= 0):
    return "0"
  while(number > 0):
    var digit = number % int(pow(12, i))
    number = number - digit
    digit = digit / int(pow(12, i-1))
    if(digit == 11):
      string = "B" + string
    elif(digit == 10):
      string = "A" + string
    else:
      string = str(digit) + string
    i += 1
  return string
