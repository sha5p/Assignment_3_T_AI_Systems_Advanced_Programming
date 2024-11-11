extends CharacterBody2D
class_name skeli
@onready var state_machine = $StateMachine
@onready var animations = $AnimatedSprite2D
@export var player:Node2D
@onready var ray_1 = $RayCast2D
@onready var ray_2 = $RayCast2D2
var health = 2
signal colliding(info)
signal Notcolliding(info)
func _ready():
	state_machine.init(self, animations,player)
func _unhandled_input(event: InputEvent) ->void:
	state_machine.process_input(event)	
func _physics_process(delta: float) ->void:
	faceAt()
	velocity.y=30
	move_and_slide()
	state_machine.process_physics(delta)
	if ray_1.is_colliding() or ray_2.is_colliding():

		if ray_1.is_colliding():

			emit_signal("colliding",self) 	
		else:

			emit_signal("colliding",self) 	
	if !ray_1.is_colliding() and !ray_2.is_colliding():
			emit_signal("Notcolliding",self) 	
func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	
func faceAt():
	var player = get_tree().get_nodes_in_group("player")
	if player[0].global_position.x > global_position.x:
		animations.flip_h = false
	else:
		animations.flip_h = true

#movment attack functions
func _on_area_2d_area_entered(_area):
	animations.play("Hit")
	if health!=0:
		health=health-1
	else:
		queue_free()
		Global.skeli=Global.skeli-1

