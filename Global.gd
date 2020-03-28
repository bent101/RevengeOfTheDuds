extends Timer

var player_score = 0
var score_bonus = 0

func add_to_player_score(amt):
	player_score += amt

func update_bonus():
	start()
	score_bonus += 5

func _on_Global_timeout():
	score_bonus = 0
