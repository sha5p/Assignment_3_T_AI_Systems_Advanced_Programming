extends State
@export var Attack_State:State
@onready var animation_player = $"../../AnimationPlayer"
@onready var death = $"../../death"


func enter() ->void:
	parent.velocity.x=0
	animations.play("Death")
	death.start()
func _unhandled_input(_event: InputEvent) ->void:
	pass
func process_physics(_delta: float) -> State:
	return null
func _process(_delta: float) -> void:
	pass


func _on_death_timeout():
	parent.queue_free()
#Die on timer end
