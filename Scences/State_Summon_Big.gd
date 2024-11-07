extends State
@export var D1_State:State

func enter() ->void:
	print("DADADDA")
func _unhandled_input(_event: InputEvent) ->void:
	pass
func process_physics(_delta: float) -> State:
	if Global.current_dimension == "Dimension1":
		return D1_State
	return null
func _process(_delta: float) -> void:
	pass
