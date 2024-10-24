extends State
const SPEED = 150.0
var GRAV =0.4

@export var fall_state:State
@export var move_state: State
@export var idle_state: State
@export var jump_state: State

@export var JUMP_VELOCITY: float = -400

@onready var animations_ = $"../../animations"


func enter() ->void:
	animation_name = "Jump"
	super()
	if Input.is_action_just_pressed("Up") and parent.is_on_floor() and Global.current_dimension == "Dimension1":
		parent.velocity.y = JUMP_VELOCITY
func process_physics(delta: float) -> State:
	if not parent.is_on_floor():
		parent.velocity.y += gravity*delta
	
	#Air Movment
	var direction = Input.get_axis("Left", "Right")
	
	if direction:
		parent.velocity.x = direction * SPEED
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, SPEED)
	if direction !=0:
		animations_.flip_h = direction <0
	parent.move_and_slide()
	if parent.is_on_floor():
		if direction !=0:
			return move_state
		return idle_state
	return null
func _unhandled_input(_event: InputEvent) ->void:
	pass
func _process(_delta: float) -> void:
	pass

		
