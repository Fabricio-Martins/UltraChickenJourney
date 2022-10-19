extends Area2D

const ACCELERATION = 500
const MAX_SPEED = 100
const FRICTION = 500

export var speed = 200
var screen_size
signal scored

var velocity = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	var input_vector = Vector2.ZERO
	
	# Pega a força aplicada no botão pressionado, nesse caso as setas.
	# Caso fosse um joypad, iria de 0 até 1 considerando a distância do analógico ao centro.
	input_vector.y = Input.get_action_strength("ui_s") - Input.get_action_strenght("ui_w")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		# Inicia a animação de andar
		$AnimatedSprite.play()
		# += aumenta a velocidade a cada frame. Multiplica por delta para se relacionar aos frames
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		print(velocity)
		# Delimita aceleração conforme o tempo em movimento
		#velocity += input_vector * ACCELERATION * delta
		# Limita a velocidade máxima atingível
		#velocity = velocity.clamped(MAX_SPEED)
	else:
		# Para a animação de andar
		$AnimatedSprite.stop()
		# A velocidade possui um atrito para parar, caso contrário o personagem parece patinar.
		# Para isso, a velocidade se move para 0,0 no vetor, tendo uma fricção multiplicada por frame/sec
		# A multiplicação por delta ajuda a impedir em casos de lag, usando o tempo real de frame/sec
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	# Lida com colisão e movimento, precisa ser KinematicBody
	# move_and_collide(velocity * delta) 
	
	# Diferente do collide, já lida com o delta nativamente. 
	# Com isso é possível deslizar nas paredes ao invés de travar
	# Retorna a velocidade atual após a colisão
	# velocity = move_and_slide(velocity) 
	
	# Impede de sair da tela
	position.y = clamp(position.y, 0, screen_size.y)
	
	# Aciona as animações da frente/trás da galinha
	if velocity.y > 0:
		$AnimatedSprite.animation = "frontView"
	elif velocity.y < 0:
		$AnimatedSprite.animation = "backView"

func _on_Player_body_entered(body):
	if body.name == "victory":
		emit_signal("scored")
	else:
		pass
	position.x = 320
	position.y = 696

func restart():
	position.x = 320
	position.y = 696
