extends ColorRect

export (PackedScene) var Enemy
export (PackedScene) var Bullet
onready var player = $Player
onready var anim_sprite = $Player/AnimatedSprite
onready var score_label = $ScoreLabel

onready var blink_timer = $HBoxContainer/BlinkContainer/BlinkProgress/BlinkTimer
onready var pound_timer = $HBoxContainer/PoundContainer/PoundProgress/PoundTimer
onready var blink_progress = $HBoxContainer/BlinkContainer/BlinkProgress
onready var pound_progress = $HBoxContainer/PoundContainer/PoundProgress

onready var blink_texture = ResourceLoader.load("res://Textures/blink_icon.png")
onready var blinking_texture = ResourceLoader.load("res://Textures/blinking_icon.png")

var player_can_blink = false
var player_can_pound = false

signal player_pound

func _ready():
	$HUD/MarginContainer.hide()
	Global.player_score = 0

func _process(delta):
	blink_progress.value = 6 - blink_timer.time_left
	pound_progress.value = 12 - pound_timer.time_left
	
	if $HUD/MarginContainer.visible: return
	
	if player_can_blink and Input.is_action_pressed("ui_select"):
		blink_progress.texture_progress = blinking_texture
		if Input.is_action_pressed("ui_right"):
			player_blink(false)
		elif Input.is_action_pressed("ui_left"):
			player_blink(true)
	else:
		blink_progress.texture_progress = blink_texture
	
	if player_can_pound and Input.is_action_pressed("ui_down"):
		emit_signal("player_pound")
		pound_timer.start()
		player_can_pound = false
		for i in range(10):
			var rand_dir = rand_range(0,2*PI)
			var rand_mag = rand_range(2, 4)
			var offset = Vector2(rand_mag * cos(rand_dir), rand_mag * sin(rand_dir))
			rect_position = offset
			yield(get_tree().create_timer(0.05), "timeout")
		rect_position = Vector2(0,0)
	
	if Input.is_action_just_pressed("ui_up"):
		$ShootTimer.emit_signal("timeout")
		$ShootTimer.start()

func _physics_process(delta):
	var x_vel = 0
	if Input.is_action_pressed("ui_right"):
		x_vel = 300
	if Input.is_action_pressed("ui_left"):
		x_vel -= 300
	anim_sprite.flip_h = x_vel < 0
	player.position.x += x_vel * delta
	player.clamp_pos()
	
	score_label.text = "Score: " + str(Global.player_score)

func _on_SpawnTimer_timeout():
	var enemy = Enemy.instance()
	connect("player_pound", enemy, "_on_player_pound")
	add_child(enemy)
	$SpawnTimer.wait_time *= 0.99

func _on_Player_body_entered(body):
	Engine.time_scale = 0.3;
	#player dies, game ends, show hud
	blink_timer.stop()
	pound_timer.stop()
	$ShootTimer.stop()
	$HUD/MarginContainer/ColorRect/ScoreLabel.text = "Score: " + str(Global.player_score)
	$HUD/MarginContainer.show()
	
	$Player/CollisionShape2D.set_deferred("disabled", true)
	anim_sprite.play("death")
	yield(anim_sprite, "animation_finished")
	anim_sprite.hide()

func _on_BlinkTimer_timeout():
	player_can_blink = true

func player_blink(is_left):
	anim_sprite.play("blink")
	yield(anim_sprite, "animation_finished")
	
	player.position.x += (-100 if is_left else 100)
	player.clamp_pos()
	
	player_can_blink = false
	blink_timer.start()
	anim_sprite.play("default")

func _on_PoundTimer_timeout():
	player_can_pound = true

func _on_ShootTimer_timeout():
	if Input.is_action_pressed("ui_up"):
		var bullet = Bullet.instance()
		bullet.position = player.position
		add_child(bullet)
