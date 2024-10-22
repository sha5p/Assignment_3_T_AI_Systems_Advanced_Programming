class_name setting
extends Control

@onready var exit = $MarginContainer/VBoxContainer/Exit

signal exit_options_menu
#Makes the exit options menu signal for main menu

func _ready(): #Not visible so process false
	set_process(false)
func _on_exit_pressed():
	#Sets pause to false if pause on pause menu
	exit_options_menu.emit()
	get_tree().paused = false
