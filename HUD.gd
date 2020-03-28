extends CanvasLayer

func _on_Button_pressed():
	Engine.time_scale = 1
	SceneChanger.change_scene("res://Game.tscn")

func _on_Button2_pressed():
	Engine.time_scale = 1
	SceneChanger.change_scene("res://Menu.tscn")
