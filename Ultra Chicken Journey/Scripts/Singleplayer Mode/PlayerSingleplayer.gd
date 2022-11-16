extends Area2D

const ACCELERATION = 500
var MAX_SPEED = 200
const FRICTION = 500

var screen_size

signal scored
signal damage

var colliding = false 
var colliding_time = 0
var pause = false
var lifes = 3

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
	
	input_vector.x = Input.get_action_strength("ui_d") - Input.get_action_strength("ui_a")
	input_vector.y = Input.get_action_strength("ui_s") - Input.get_action_strength("ui_w")
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
		
	if velocity.x > 0:
		$AnimatedSprite.animation = "rightView"
	elif velocity.x < 0:
		$AnimatedSprite.animation = "leftView"
		

func _on_Player_body_entered(body):
	if colliding:
		return
		
	if body.name == "victory":
		emit_signal("scored")
		start_position()
	else:
		colliding = true
		emit_signal("damage")
		$AnimatedSprite.animation = "knockback"
		colliding_time = 0.5
		
	return

func paused():
	pause = true
	start_position()

func start_position():
	position.x = 659
	position.y = 670

func _on_Singleplayer_rip():
	$AnimatedSprite.animation = "ded"
	$AnimatedSprite.play("ded")
