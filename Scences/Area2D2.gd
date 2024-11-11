extends Area2D
var health =2
const THE_END = preload("res://the_end.tscn")
func _on_area_entered(_area):
	if health==0:
		call_deferred("set_enable_monitoring", false)
		get_tree().change_scene_to_file("res://the_end.tscn")
	else:
		health=health-1
#for health magment of player
