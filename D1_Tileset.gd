extends TileMap
func _physics_process(delta: float) ->void:
	var tile_map = $"."
	if Global.current_dimension == "Dimension1":
		tile_map.visible=true
	elif Global.current_dimension == "Dimension2":
		tile_map.visible=false
