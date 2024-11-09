extends Control


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scences/Menu_Scences/main_menu.tscn")
