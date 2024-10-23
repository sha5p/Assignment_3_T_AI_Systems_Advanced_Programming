extends State
@export var D2:State
@onready var animat = $"../../../AnimatedSprite2D"

func enter() ->void:
	animat.play("Sleep")
func _unhandled_input(event: InputEvent) ->void:
	pass
func process_physics(delta: float) -> State:
	if Global.current_dimension == "Dimension2":
		return D2
	return null
func _process(delta: float) -> void:
	pass
