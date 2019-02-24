extends SceneTree

func _init():
  for i in range(12):
    print(OS.get_unix_time())
  quit()
