extends State
@onready var timer = $"../../Timer"
@onready var animation_player_2 = $"../../AnimationPlayer2"

@onready var animation_player = $"../../AnimationPlayer"
@onready var animations_2 = $"../../animations2"
@onready var timer_2 = $"../../Timer2"


@export var none_state: State
var attack:String
var attacked:bool =false
func enter() ->void:
	attacked =true
	animation_name = ""
	if Global.current_dimension == "Dimension1":
		if animations.flip_h:
			attack="attack_2"
		else:
			attack="attack"
		animation_player.play(attack)
		timer.start()
	else:
		if animations_2.flip_h:
			attack="attack_2"
		else:
			attack="attack"
		animation_player_2.play(attack)
		timer_2.start()
func _unhandled_input(event: InputEvent) ->void:
	pass
func process_physics(delta: float) -> State:
	if !attacked:
		return none_state
	return null
func _process(_delta: float) -> void:
	pass
func _on_timer_timeout():
	attacked = false
func _on_attack_body_entered(body):
	print("hit")



func _on_timer_2_timeout():
	animations_2.stop()
	print("finish swap back")
	attacked = false
