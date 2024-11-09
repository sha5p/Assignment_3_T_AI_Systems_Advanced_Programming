extends State
var stateControl:String
@export var RunAt:State
@onready var nodes_in_group = get_tree().get_nodes_in_group("control")
@onready var animated_sprite_2d = $"../../../AnimatedSprite2D"
@onready var animation_player = $"../../../AnimationPlayer"



var z=true
func enter():
	var first_node = nodes_in_group[0]
	parent.velocity = Vector2.ZERO
	animation_name = "Attack"
	if !animated_sprite_2d.flip_h:
		animation_player.play("Attack_1")
	else:
		animation_player.play("Attack_2")
	animated_sprite_2d.play("Attack")
	if z:
		first_node.connect("Runat", Callable(self, "state_func"))
		z=false
	print("attack: ",stateControl)
	super()
func _unhandled_input(_event: InputEvent) ->void:
	pass
func process_physics(_delta: float) -> State:
	if Global.current_dimension == "Dimension2":
		return null
	if stateControl == "RunAt":
		stateControl=""
		return RunAt
		
	return null
func _process(_delta: float) -> void:
	pass
func state_func(state) -> State:
	if str(state) == str(parent):
		stateControl="RunAt"
	return null
