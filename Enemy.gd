extends RigidBody2D

onready var sprite = $AnimatedSprite
export (PackedScene) var ComboLabel

func _ready():
	var anims = ["vincent", "ray", "ethan"]
	var anim = anims[randi() % anims.size()]
	sprite.animation = anim
	
	var w = get_viewport_rect().size.x
	position.x = rand_range(w * 0.2, w * 0.8)
	position.y = -70
	linear_velocity.x = rand_range(-200, 200)
	linear_velocity.y = 50
	angular_velocity = rand_range(-10, 10)

func _on_player_pound():
	linear_velocity.y = -550

func _on_bullet_hit():
	Global.add_to_player_score(10)
	
	var combo_label = ComboLabel.instance()
	combo_label.position = position
	$CanvasLayer.add_child(combo_label)
	
	$CollisionShape2D.set_deferred("disabled", true)
	sprite.play("death")
	yield(sprite, "animation_finished")
	queue_free()