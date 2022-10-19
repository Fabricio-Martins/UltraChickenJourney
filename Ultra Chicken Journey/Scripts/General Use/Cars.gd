extends RigidBody2D


func _ready():
	var car_color = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = car_color[randi() % car_color.size()]

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
