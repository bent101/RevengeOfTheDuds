extends Area2D

func clamp_pos():
	position.x = clamp(position.x, 60, get_viewport_rect().size.x-60)