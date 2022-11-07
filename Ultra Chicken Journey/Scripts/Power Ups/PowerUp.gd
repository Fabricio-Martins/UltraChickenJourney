tool
extends Resource
class_name PowerUp

export(String) var name = ""
export(SpriteFrames) var spriteFrames

func getSprites() -> SpriteFrames:
	return spriteFrames
