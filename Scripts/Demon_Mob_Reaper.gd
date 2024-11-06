extends CharacterBody2D
class_name reaper
@onready var state_machine = $StateMachine
@onready var animations = $AnimatedSprite2D

@export var player:Node2D
func _ready():
	state_machine.init(self, animations,player)
func _unhandled_input(event: InputEvent) ->void:
	state_machine.process_input(event)
func _physics_process(delta: float) ->void:
	state_machine.process_physics(delta)
func _process(delta: float) -> void:
	state_machine.process_frame(delta)
