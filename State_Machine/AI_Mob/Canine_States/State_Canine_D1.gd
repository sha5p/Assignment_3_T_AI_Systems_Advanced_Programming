extends State
@export var sleep_state:State
@export var D2:State
func enter() ->void:
	pass
func _unhandled_input(event: InputEvent) ->void:
	pass
func process_physics(delta: float) -> State:
	if Global.current_dimension == "Dimension2":
		return D2
	return sleep_state
func _process(delta: float) -> void:
	pass
