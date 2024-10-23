class_name State_AI
extends Node

@export var animation_name:String
@export var move_speed: float= 400

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var parent: CharacterBody2D
var animations:AnimatedSprite2D
func enter() ->void:
	parent.animations.play(animation_name)
func exit() -> void:
	pass
func process_input(_event: InputEvent) ->State_AI:
	return null
func process_frame(_delta: float) -> State_AI:
	return null
	
