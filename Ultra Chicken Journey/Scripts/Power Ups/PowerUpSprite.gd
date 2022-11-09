tool
extends AnimatedSprite

export(Resource) var My_PowerUp setget _setPowerUp

func _setPowerUp(newPowerUp : Resource):
	My_PowerUp = newPowerUp
	self.frames = My_PowerUp.getSprites()
