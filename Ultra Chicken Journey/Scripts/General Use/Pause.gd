extends Control

var pause = false

func _ready():
	visible = false
	$ControlsHud.visible = false
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pause =  !pause
		get_tree().paused = pause
		visible = pause

func _on_ResumeButton_pressed():
	get_tree().paused = false
	visible = false

func _on_ExitButton_pressed():
	get_tree().change_scene("res://Menu.tscn")

func _on_Menu_Button_pressed():
	pause = !pause
	get_tree().paused = pause
	visible = pause
	$PauseHud/VBoxContainer/VBoxContainer/MarginContainer/ResumeButton.grab_focus()
	
func _on_ControlsButton_pressed():
	$PauseHud.visible = false
	$ControlsHud.visible = true

func _on_ReturnButton_pressed():
	$PauseHud.visible = true
	$ControlsHud.visible = false
