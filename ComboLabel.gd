extends Node2D

func _ready():
	if Global.score_bonus == 0: hide()
	$Label.text = "Combo! +" + str(Global.score_bonus)
	Global.add_to_player_score(Global.score_bonus)
	Global.update_bonus()
