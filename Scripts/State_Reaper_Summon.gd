extends State
@export var D2:State
@export var control:State
@onready var animated_sprite_2d = $"../../../AnimatedSprite2D"
@onready var summon = $"../../../Summon"
const SKELETON = preload("res://Scences/Skeleton.tscn")
func enter() ->void:
	animated_sprite_2d.play("Summon")
	summon.play("Summon")
	summon.visible=true
	parent.velocity = Vector2.ZERO*0
	parent.move_and_slide()
	
	
	var summon=SKELETON.instantiate()
	summon.position = Vector2(randf_range(10,1000),550)
	add_child(summon)
	
	
	var summon_2=SKELETON.instantiate()
	summon_2.position = Vector2(randf_range(10,1000),550)
	add_child(summon_2)
func _unhandled_input(_event: InputEvent) ->void:
	pass
func process_physics(_delta: float) -> State:
	
	if Global.current_dimension == "Dimension2":
		return D2
	return control
func _process(_delta: float) -> void:
	pass
