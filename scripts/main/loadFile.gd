# Warning not tested
static func load_file(add_timers):
  var Data = load("res://scripts/timer/data.gd")
  var file = File.new()
  file.open("res://timers.txt", file.READ)
  while(true):
    var line = file.get_line()
    if file.eof_reached():
      break
    if line.begins_with("#"):
      continue
    var pound = line.find("#")
    if pound > -1:
      line = line.substr(0, pound)
    var colon = line.rfind(":")
    var base = null
    if colon > -1:
      if line[colon + 1] == "1":
        if line[colon + 2] == "0":
          base = Data.Bases.Decimal
          line = line.substr(0, colon)
        elif line[colon + 2 ] == "2":
          base = Data.Bases.Doudecimal
          line = line.substr(0, colon)
    add_timers.add_timer(line, base)

static func load_save_file(save_file, add_timers):
  var Data = load("res://scripts/timer/data.gd")
  var file = File.new()
#  if !file.file_exists(save_file):
#    print("File \"" + save_file + "\" does not exist")
#    return
  file.open(save_file, file.READ)
  file.get_line()
  while(true):
    var line = file.get_line()
    if file.eof_reached():
      break
    var time_index = line.rfind(" ")
    var time = int(line.substr(time_index, line.length() - time_index))
    line = line.substr(0, time_index)
    var base_index = line.rfind(" ")
    var base_str = line.substr(base_index, line.length() - base_index)
    var base
    if base_str == "10":
      base = Data.Bases.Decimal
    else:
      base = Data.Bases.Doudecimal
    line = line.substr(0, base_index)
    add_timers.add_timer(line, base, time)

static func write_file(directory, start_time, timers, temperary = false):
  var date = OS.get_date()
  var date_string = str(date["year"]) + "-"
  var month = date["month"]
  if month < 10:
    date_string = date_string + "0" + str(month) + "-"
  else:
    date_string = date_string + str(month) + "-"
  var day = date["day"]
  if day < 10:
    date_string = date_string + "0" + str(day)
  else:
    date_string = date_string + str(day)
  var time = OS.get_time()
  var time_string = str(time["hour"]) + ":"
  var minutes = time["minute"]
  if(minutes < 10):
    time_string = time_string + "0" + str(minutes) + ":"
  else:
    time_string = time_string + str(minutes) + ":"
  var seconds = time["second"]
  if seconds < 10:
    time_string = time_string + "0" + str(seconds)
  else:
    time_string = time_string + str(seconds)
  var file_name = date_string
  if temperary:
    file_name = ".time.tmp"
  file_name = directory + file_name
  var file = File.new()
  var save_file = File.new()
  if file.file_exists(file_name):
    if !temperary && file.get_modified_time(file_name) < start_time:
      var i = 1
      while file.file_exists(file_name + "_" + str(i)):
        if file.get_modified_time(file_name + "_" + str(i)) < start_time:
          i += 1
        else:
          break
      file_name = file_name + "_" + str(i)
  file.open(file_name, file.WRITE)
  save_file.open(file_name + ".save", save_file.WRITE)
  file.store_line(date_string + " " + time_string)
  save_file.store_line(date_string + " " + time_string)
  var csv_text = date_string
  for i in timers:
    file.store_line(i.get_node("TimerName").text + " " \
        + i.get_node("MainButtons/Base").text + " " + i.get_node("Label").text)
    save_file.store_line(i.get_node("TimerName").text + " " \
        + i.get_node("MainButtons/Base").text + " " \
        + str(i.data.get_time()))
    csv_text = csv_text + "," + str(i.data.get_time() / 3600.0)
  file.close()
  file.open(file_name + ".csv", file.WRITE)
  file.store_line(csv_text)
  file.close()
