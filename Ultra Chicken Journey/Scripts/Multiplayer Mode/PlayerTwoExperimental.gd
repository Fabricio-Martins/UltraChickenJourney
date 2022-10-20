extends Area2D

const ACCELERATION = 500
const MAX_SPEED = 200
const FRICTION = 500

var screen_size
signal scored
var colliding = false 
var colliding_time = 0
var pause = false

var velocity = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	var input_vector = Vector2.ZERO

	if pause:
		return
	if colliding:
		$AnimatedSprite.play()
		colliding_time -= delta
		position.y += MAX_SPEED * delta
		if colliding_time <= 0:
			colliding_time = 0
			colliding = false
			$AnimatedSprite.stop()
			$AnimatedSprite.animation = "idle"
		return
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		$AnimatedSprite.play()
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		print(velocity)
	else:
		$AnimatedSprite.stop()
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	position += velocity * delta
		
	# Impede de sair da tela
	position.y = clamp(position.y, 0, screen_size.y)
	
	# Aciona as animações
	if velocity.y > 0:
		$AnimatedSprite.animation = "frontView"
	elif velocity.y < 0:
		$AnimatedSprite.animation = "backView"

func _on_Player2_body_entered(body):
	if colliding:
		return
		
	if body.name == "victory":
		emit_signal("scored")
		start_position()
	else:
		colliding = true
		$AnimatedSprite.animation = "knockback"
		colliding_time = 0.5
	
	return

func paused():
	pause = true
	start_position()

func start_position():
	position.x = 800
	position.y = 696
