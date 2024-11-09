extends State
@export var Attack:State
@export var Chase:State
@export var D2:State
@onready var nodes_in_group = get_tree().get_nodes_in_group("control")


func enter() ->void:
	animation_name = "Idle"
	super()
	var first_node = nodes_in_group[0]
	first_node.connect("insturction", Callable(self, "state_func"))
func _unhandled_input(_event: InputEvent) ->void:
	pass
func process_physics(_delta: float) -> State:
	if Global.current_dimension == "Dimension2":
		return D2
	return null
func _process(_delta: float) -> void:
	pass
	
	
func state_func(state):
	print("Item picked up: ", state)
	# React to the signal (e.g., change state)
func tree():
	pass
