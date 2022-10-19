extends Control

var timer = null
var flag = 0

func _ready():
	$MarginContainer/ContainerOne/ContainerTwo/MarginContainer/SingleplayerButton.grab_focus()

func _on_MultiplayerButton_pressed():
	get_tree().change_scene("res://Multiplayer.tscn")
	get_tree().paused = false

func _on_SingleplayerButton_pressed():
	get_tree().change_scene("res://Singleplayer.tscn")
	get_tree().paused = false

func _on_Leaderboard_pressed():
	pass # Replace with function body.
