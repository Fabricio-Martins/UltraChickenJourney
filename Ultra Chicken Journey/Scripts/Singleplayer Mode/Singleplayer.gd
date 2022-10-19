extends Node

const new_car = preload("res://Cars.tscn")

var slow_road = [653, 535, 417, 353, 234, 172]
var fast_road = [596, 474, 296, 111]

var lives = 5
var player_score = 0

signal rip

func _ready():
	$CanvasLayer/RestartButton.hide()
	$CanvasLayer/BMenuButton.hide()
	randomize()

func _on_Timer_Fast_Road_timeout():
	var fast_car = new_car.instance()
	add_child(fast_car)
	fast_car.position.y = fast_road[randi() % fast_road.size()]
	if fast_car.position.y > 400:
		fast_car.position.x = -10
		fast_car.linear_velocity = Vector2(rand_range(700, 710), 0)
	else:
		fast_car.position.x = 1300
		fast_car.linear_velocity = Vector2(rand_range(-700, -710), 0)

func _on_Timer_Slow_Road_timeout():
	var slow_car = new_car.instance()
	add_child(slow_car)
	slow_car.position.y = slow_road[randi() % slow_road.size()]
	if slow_car.position.y > 400:
		slow_car.position.x = -10
		slow_car.linear_velocity = Vector2(rand_range(300, 310), 0)
	else:
		slow_car.position.x = 1300
		slow_car.linear_velocity = Vector2(rand_range(-300, -310), 0)

func _on_Player_scored():
	player_score += 1
	$CanvasLayer/Scoreboard.text = str(player_score)

func _on_Button_pressed():
	var err = get_tree().reload_current_scene()
	if err != OK: print(err)


func _on_Player_damage():
	lives -= 1
	var text = "Lives Left: %d"
	$Health.text = text % [lives]
	if lives == 0:
		$Timer_Fast_Road.stop()
		$Timer_Slow_Road.stop()
		$GameOver.text = "GAME OVER!"
		emit_signal("rip")
		$CanvasLayer/RestartButton.show()
		$CanvasLayer/BMenuButton.show()
		$Player.paused()
		lives = 5


func _on_BMenuButton_pressed():
	var err = get_tree().change_scene("res://Menu.tscn")
	if err != OK: print(err)
