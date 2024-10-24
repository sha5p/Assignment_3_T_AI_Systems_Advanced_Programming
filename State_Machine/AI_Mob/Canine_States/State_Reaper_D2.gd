extends State
@export var D1_State:State
@export var Search_State:State
@export var Attack_State:State
@export var RunAt_State:State
@export var RunAway_State:State
@onready var anim = $"../../AnimatedSprite2D"



func enter() ->void:
	anim.modulate = Color(0, 100, 100)  
	
func _unhandled_input(_event: InputEvent) ->void:
	pass
func process_physics(_delta: float) -> State:
	if Global.current_dimension == "Dimension1":
		return D1_State
	return Search_State
func _process(_delta: float) -> void:
	pass
