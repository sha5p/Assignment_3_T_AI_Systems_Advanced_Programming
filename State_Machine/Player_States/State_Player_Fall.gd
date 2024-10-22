extends State

@export var idle_state:State
@export var jump_state: State
@export var move_state: State

func enter() ->void:
	animation_name = ""
	super()

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("Up") and parent.is_on_floor():
		return jump_state
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		return move_state
	return null
func process_physics(delta: float) -> State:
	parent.velocity.y+=gravity*delta
	parent.move_and_slide()
	if parent.is_on_floor():
		return idle_state
	return null
func _process(_delta: float) -> void:
	pass
