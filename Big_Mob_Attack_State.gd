extends State

@export var Attack_State:State


@export var death_state:State
@onready var animation_player = $"../../AnimationPlayer"

var death:bool=false
@export var Relax_State:State
var attack=false
@onready var attack_finished = $"../../Attack finished"


func enter() ->void:
	attack_finished.start()
	parent.velocity.x=0
	animation_player.play("Right Attack")
func _unhandled_input(_event: InputEvent) ->void:
	pass
func process_physics(_delta: float) -> State:
	if death:
		return death_state
	if attack:
		attack=false
		return Relax_State
	return null
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout():
	death=true


func _on_attack_finished_timeout():
	attack=true
