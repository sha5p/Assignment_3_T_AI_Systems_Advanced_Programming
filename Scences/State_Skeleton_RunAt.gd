extends State
var speed=20
var stateControl:String
@onready var animated_sprite_2d = $"../../../AnimatedSprite2D"



@export var attack:State
@onready var nodes_in_group = get_tree().get_nodes_in_group("control")
var z=true
func enter():

	var first_node = nodes_in_group[0]
	if z:
		first_node.connect("insturction_2", Callable(self, "state_func"))
		z=false
	animation_name = "Run"
	animated_sprite_2d.play("Run")
	super()
	var players = get_tree().get_nodes_in_group("player")
	var dir = (players[0].position - parent.global_position).normalized()
	parent.velocity = dir * speed
func _unhandled_input(_event: InputEvent) ->void:
	pass
func process_physics(_delta: float) -> State:
	var players = get_tree().get_nodes_in_group("player")
	var dir = Vector2((players[0].position.x - parent.global_position.x),20).normalized()
	parent.velocity= dir * speed
	if Global.current_dimension == "Dimension2":
		return null
	if stateControl == "attack":
		stateControl=""
		return attack
	return null
func _process(_delta: float) -> void:
	pass
func state_func(state) -> State:
	if str(state) == str(parent):
		stateControl="attack"
	return null
