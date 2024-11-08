extends State
@export var D1_State:State
@export var Search_State:State
@export var Attack_State:State
@export var Summon_State:State
const BIG_MOB_D_2 = preload("res://Big_Mob_D2.tscn")

func enter() ->void:
	parent.velocity = Vector2.ZERO*0
	parent.move_and_slide()
	
	var summon=BIG_MOB_D_2.instantiate()
	summon.position = Vector2(randf_range(10,1000),550)
	add_child(summon)
func _unhandled_input(_event: InputEvent) ->void:
	pass
func process_physics(_delta: float) -> State:
	if Global.current_dimension == "Dimension1":
		return D1_State
	return Attack_State
func _process(_delta: float) -> void:
	pass
