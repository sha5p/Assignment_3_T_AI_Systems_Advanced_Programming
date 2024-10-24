extends State
const SPEED = 300.0
@onready var animations_ = $"../../animations"
@onready var animations_2 = $"../../animations2"

@export var fall_state:State
@export var jump_state: State
@export var idle_state: State

func enter() ->void:
	animation_name = "Move"
	super()
	animations_2.play("Move")
	var direction = Input.get_axis("Left", "Right")	
	parent.velocity.x = direction * SPEED
func process_input(_event: InputEvent) -> State:
	var direction = Input.get_axis("Left", "Right")	

	if direction:
		parent.velocity.x = direction * SPEED
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, SPEED)
	if Input.is_action_just_pressed("Up") and parent.is_on_floor():
		return jump_state		
	parent.move_and_slide()
	
	if abs(parent.velocity.x) < 1:  # Adjust the threshold as needed
		return idle_state
	return null
func process_physics(delta: float) -> State:
	parent.velocity.y=gravity*delta
	if abs(parent.velocity.x) ==0:  # Adjust the threshold as needed
		return idle_state
	parent.move_and_slide()
	if !parent.is_on_floor():
		return fall_state
	
	return null
