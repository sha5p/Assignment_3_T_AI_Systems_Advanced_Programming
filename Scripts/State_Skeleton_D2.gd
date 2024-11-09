extends State
@export var D2:State
@export var attack:State
@export var runat:State
@export var runaway:State

@onready var anim = $"../../AnimatedSprite2D"
@onready var nodes_in_group = get_tree().get_nodes_in_group("control")
var stateControl:String
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
	if stateControl == "runat":
		return runat
	if stateControl == "attack":
		return attack
	if stateControl == "runaway":
		return runaway
	return null
func _process(_delta: float) -> void:
	pass
func state_func(state) -> State:
	if state == "runat":
		stateControl="runat"
	if state == "attack":
		stateControl="attack"
	if state == "runaway":
		stateControl="runaway"
	return null
	# React to the signal (e.g., change state)
func tree():
	pass
