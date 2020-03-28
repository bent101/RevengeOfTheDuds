extends Area2D

func _physics_process(delta):
	position.y -= 600 * delta

func _on_VisibilityNotifier2D_screen_exited():
	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()

func _on_Bullet_body_entered(body):
	body.call("_on_bullet_hit")
	queue_free()
