extends CanvasLayer

var is_startup_anim = true

func change_scene(path):
	$ColorRect.show()
	is_startup_anim = false
	$AnimationPlayer.play("fade")
	yield($AnimationPlayer, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	$AnimationPlayer.play_backwards("fade")
	yield($AnimationPlayer, "animation_finished")
	$ColorRect.hide()