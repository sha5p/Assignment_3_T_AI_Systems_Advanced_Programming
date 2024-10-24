extends State
@export var search_state:State
@export var D2:State
@onready var anim = $"../../AnimatedSprite2D"


func enter() ->void:
	pass
func _unhandled_input(_event: InputEvent) ->void:
	pass
func process_physics(_delta: float) -> State:
	if Global.current_dimension == "Dimension2":
		return D2
	return search_state
func _process(_delta: float) -> void:
	pass
func tree():
	pass
