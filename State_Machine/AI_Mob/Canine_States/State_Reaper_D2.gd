extends State
@export var D1_State:State
@export var Search_State:State
@export var Summon_State:State




func enter() ->void:
	pass
func _unhandled_input(_event: InputEvent) ->void:
	pass
func process_physics(_delta: float) -> State:
	if Global.current_dimension == "Dimension1":
		return D1_State
	return Search_State
func _process(_delta: float) -> void:
	pass
func tree():
	pass
