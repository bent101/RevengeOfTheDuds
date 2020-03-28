extends CenterContainer

func _ready():
	randomize()
	if SceneChanger.is_startup_anim:
		$"../AnimationPlayer".play("start")

func _on_StartButton_pressed():
	SceneChanger.change_scene("res://Game.tscn")

func _on_MoreButton_pressed():
	SceneChanger.change_scene("res://More.tscn")

func _on_HowToButton_pressed():
	SceneChanger.change_scene("res://HowTo.tscn")