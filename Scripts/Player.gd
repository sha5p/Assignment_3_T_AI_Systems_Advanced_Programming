extends CharacterBody2D
class_name Player
@onready var animations2 = $animations2
@onready var animation_player_3 = $AnimationPlayer3

@onready var animations = $animations
@onready var state_machine = $Movment_StateMachine
#@onready var demension_state_machine = $Demension_StateMachine
@onready var attack_state_machine_2 = $Attack_StateMachine2
var player
func _ready():
	print(global_position,"Player check")
	state_machine.init(self, animations,player)
	#demension_state_machine.init(self,animations)
	attack_state_machine_2.init(self,animations,player)
func _unhandled_input(event: InputEvent) ->void:
	if Input.is_action_just_pressed("Change Dimension"):
		animation_player_3.play("disort")
		print(Global.current_dimension)
		if Global.current_dimension == "Dimension1":
			Global.change_dimension(Global.Dimension.Dimension2)
			animations2.visible=true
			animations.visible =false
			print(Global.current_dimension)
		else:
			Global.change_dimension(Global.Dimension.Dimension1)
			animations2.visible=false
			animations.visible =true
	state_machine.process_input(event)
	#demension_state_machine.process_input(event)
	attack_state_machine_2.process_input(event)
func _physics_process(delta: float) ->void:
	var direction = Input.get_axis("Left", "Right")	
	if direction !=0:
		animations2.flip_h = direction <0
		animations.flip_h = direction <0
	state_machine.process_physics(delta)
	#demension_state_machine.process_physics(delta)
	attack_state_machine_2.process_physics(delta)
func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	#demension_state_machine.process_physics(delta)
	attack_state_machine_2.process_physics(delta)

func Player():
	pass