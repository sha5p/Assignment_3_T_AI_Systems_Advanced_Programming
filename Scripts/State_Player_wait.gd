extends State
@onready var animation_player = $"../../AnimationPlayer"
@onready var animation_player_2 = $"../../AnimationPlayer2"


@export var attack_state: State
func enter() ->void:
	animation_name = "Idle"
	animation_player.stop()
	animation_player_2.stop()
	super()
func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("Attack") and parent.is_on_floor():
		return attack_state
	return null
func process_physics(_delta: float) -> void:
	pass
func _process(_delta: float) -> void:
	pass
