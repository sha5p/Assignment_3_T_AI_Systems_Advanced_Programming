extends State

@onready var animations_2 = $"../../animations2"

@export var fall_state:State
@export var jump_state: State
@export var move_state: State

func enter() ->void:
	animation_name = "Idle"
	super()
	animations_2.play("Idle")
	parent.velocity.x=0
func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("Up") and parent.is_on_floor():
		return jump_state
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		return move_state
	return null
func process_physics(delta: float) -> State:
	parent.velocity.y+=gravity*delta
	parent.move_and_slide()
	if !parent.is_on_floor():
		return fall_state
	return null
func _process(_delta: float) -> void:
	pass
