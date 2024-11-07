extends State
@export var D1_State:State
@export var Search_State:State
@export var Attack_State:State
@export var RunAt_State:State
@export var RunAway_State:State

@onready var animated_sprite_2d = $"../../../AnimatedSprite2D"
@onready var animation_player = $"../../../AnimationPlayer"
var search=false
func enter() ->void:
	search=false
	print(animation_player)
	animation_name = ""
	if animated_sprite_2d.flip_h:
		animation_player.play("Attack_2")
	elif !animated_sprite_2d.flip_h:
		animation_player.play("Attack")
func _unhandled_input(_event: InputEvent) ->void:
	pass
func process_physics(_delta: float) -> State:
	if Global.current_dimension == "Dimension2":
		return D1_State
	if search:
		return Search_State
		search=false
	return null
func _process(_delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Attack" or anim_name =="Attack_2":
		parent.position=Vector2(randf_range(10,1000),randf_range(200,100))
		search=true
func Move():
	pass
