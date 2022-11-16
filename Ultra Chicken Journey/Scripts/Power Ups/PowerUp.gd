tool
extends AnimatedSprite
class_name PowerUp

export(String) var powerUpName = ""
export(SpriteFrames) var spriteFrames

var picked_up = false

func powerEffectOnPlayer(body):
	print(name + ": Você esqueceu de dar OVERRIDE aqui")

func _on_Area2D_area_entered(area):
	print("Entered!")
	if area.get("TYPE") == "Player" && picked_up == false:
		picked_up = true
		powerEffectOnPlayer(area)
		queue_free()
