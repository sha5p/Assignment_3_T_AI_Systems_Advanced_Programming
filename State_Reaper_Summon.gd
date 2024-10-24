extends State
@export var D2:State
@onready var animated_sprite_2d = $"../../../AnimatedSprite2D"
@onready var summon = $"../../../Summon"

func enter() ->void:
	print("Summoning state")
	animated_sprite_2d.play("Summon")
	summon.play("Summon")
	summon.visible=true
	parent.velocity = Vector2.ZERO*0
	parent.move_and_slide()
func _unhandled_input(_event: InputEvent) ->void:
	pass
func process_physics(_delta: float) -> State:
	if Global.current_dimension == "Dimension2":
		return D2
	return null
func _process(_delta: float) -> void:
	pass
