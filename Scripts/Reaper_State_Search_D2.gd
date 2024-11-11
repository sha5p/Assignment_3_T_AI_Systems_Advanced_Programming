extends State
@export var D2_State:State
@export var Attack_State:State
@export var RunAt_State:State
@export var RunAway_State:State
@export var Summon_State:State
@onready var nav_agent:= $"../../../NavigationAgent2D" as NavigationAgent2D
@onready var animated_sprite_2d = $"../../../AnimatedSprite2D"
@onready var timer = $"../../../Timer"
@onready var summon = $"../../../Summon"

#movment attack functions
var z:bool = false
var AttaclState:bool=false
var speed = 100
func enter() ->void:
	summon.visible=false
	z=false
	timer.start()
	animation_name = "Search"
	super()
func _unhandled_input(_event: InputEvent) ->void:
	pass
func process_physics(_delta: float) -> State:
	
	if player:
		face_player()
	var dir =parent.to_local(nav_agent.get_next_path_position()).normalized()
	parent.velocity=dir*speed
	parent.move_and_slide()
	if Global.current_dimension == "Dimension2":
		return D2_State
	if z and Global.skeli==2:
		parent.velocity = Vector2.ZERO*0
		parent.move_and_slide()
		timer.stop()
		return Summon_State
	if AttaclState and Global.skeli==0:
		AttaclState=false
		return Attack_State
	return null
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("player") and not timer.is_stopped() and Global.skeli==2 and Global.current_dimension == "Dimension1":
		z=true
	if body.is_in_group("player") and not timer.is_stopped() and Global.skeli==0 and Global.current_dimension == "Dimension1":
		
		parent.position=player.global_position
		timer.stop()
		AttaclState=true
func face_player():
	var player = get_tree().get_nodes_in_group("player")
	if player[0].global_position.x > parent.global_position.x:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true

func _makepath() ->void:
	nav_agent.target_position=player.global_position
func _on_timer_timeout() ->void:
	_makepath()
