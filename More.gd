extends CenterContainer

func _on_DDD1Button_pressed():
	OS.shell_open("https://studio-heart-engine.itch.io/dodge-the-duds")

func _on_ItchioButton_pressed():
	OS.shell_open("https://studio-heart-engine.itch.io")

func _on_Button_pressed():
	get_tree().change_scene("res://Menu.tscn")
