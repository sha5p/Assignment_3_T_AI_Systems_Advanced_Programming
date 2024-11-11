extends Area2D


func _on_body_entered(body):
	if body.has_method("Player"):
		get_tree().change_scene_to_file("res://Death.tscn")
#for death detection
