extends State
@export var D1_State:State
@export var Search_State:State
@export var Attack_State:State
@export var RunAt_State:State
@export var RunAway_State:State



func enter() ->void:
	pass
func _unhandled_input(event: InputEvent) ->void:
	pass
func process_physics(delta: float) -> State:
	if Global.current_dimension == "Dimension1":
		return D1_State
	return Search_State
func _process(delta: float) -> void:
	pass
