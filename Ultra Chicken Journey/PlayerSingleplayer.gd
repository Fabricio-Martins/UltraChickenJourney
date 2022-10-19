extends Area2D

export var speed = 200
var screen_size
signal scored
signal damage
var colliding = false 
var colliding_time = 0
var pause = false
var lifes = 3

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	if pause:
		return
	if colliding:
		$AnimatedSprite.play()
		colliding_time -= delta
		position.y += speed * delta
		if colliding_time <= 0:
			colliding_time = 0
			colliding = false
			$AnimatedSprite.stop()
			$AnimatedSprite.animation = "idle"
		return
	
	var velocity = Vector2()
	if Input.is_action_pressed("ui_s") or Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_w") or Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	position += velocity * delta
	
	# Impede de sair da tela
	position.y = clamp(position.y, 0, screen_size.y)
	
	# Aciona as animações
	if velocity.y > 0:
		$AnimatedSprite.animation = "frontView"
	elif velocity.y < 0:
		$AnimatedSprite.animation = "backView"
		

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


func restart():
	pause = false
	start_position()

func pause():
	pause = true
	start_position()

func start_position():
	position.x = 659
	position.y = 670

func _on_Singleplayer_rip():
	$AnimatedSprite.animation = "ded"
	$AnimatedSprite.play("ded")
