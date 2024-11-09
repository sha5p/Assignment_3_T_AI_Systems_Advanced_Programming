extends State

@export var death_state:State
@onready var left_cast = $"../../leftCast"
@onready var right_cast = $"../../RightCast"

@export var Attack_State_2:State
@export var Attack_State:State
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
var direction=0
var death:bool=false

func enter() ->void:
	change_direction()
	animated_sprite_2d.play("Idle")
func _unhandled_input(_event: InputEvent) ->void:
	pass
func process_physics(_delta: float) -> State:
	animated_sprite_2d.play("Walk")
	if direction >0:
		direction=1
		animated_sprite_2d.flip_h=false
	else:
		direction=-1
		animated_sprite_2d.flip_h=true
	parent.velocity.x= direction*80
	parent.move_and_slide()
	if left_cast.is_colliding():
		return Attack_State_2
	if right_cast.is_colliding():
		return Attack_State
	if death:
		return death_state
	return null
func _process(_delta: float) -> void:
	pass
func change_direction():
	direction = randf_range(-1, 1)


func _on_timer_2_timeout():
	if parent.velocity.x != 0:
		change_direction()


func _on_timer_timeout():
	death=true
