extends Node

const new_car = preload("res://Cars.tscn")

var slow_road = [653, 535, 417, 353, 234, 172]
var fast_road = [596, 474, 296, 111]

var score_player_one = 0
var score_player_two = 0

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
	if score_player_one < 5:
		score_player_one += 1
		$CanvasLayer/Scoreboard1.text = str(score_player_one)
	if score_player_one >= 5:
		$CanvasLayer/RestartButton.show()
		$CanvasLayer/BMenuButton.show()
		$Winner.text = "Player One Won!"
		$Player.paused()
		$Player2.paused()
		$Timer_Fast_Road.stop()
		$Timer_Slow_Road.stop()

func _on_Player2_scored():
	if score_player_two < 5:
		score_player_two += 1
		$CanvasLayer/Scoreboard2.text = str(score_player_two)
	if score_player_two >= 5:
		$CanvasLayer/RestartButton.show()
		$CanvasLayer/RestartButton.grab_focus()
		$CanvasLayer/BMenuButton.show()
		$Winner.text = "Player Two Won!"
		$Player.paused()
		$Player2.paused()
		$Timer_Fast_Road.stop()
		$Timer_Slow_Road.stop()

func _on_RestartButton_pressed():
	var err = get_tree().reload_current_scene()
	if err != OK: print(err)


func _on_BMenuButton_pressed():
	get_tree().change_scene("res://Menu.tscn")
