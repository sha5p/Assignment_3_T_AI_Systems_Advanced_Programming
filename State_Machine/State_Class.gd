class_name State
extends Node

@export var animation_name:String
@export var move_speed: float= 400

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var parent: CharacterBody2D
var animations:AnimatedSprite2D
var animations2:AnimatedSprite2D
func enter() ->void:
	if Global.current_dimension == "Dimension1":
		parent.animations.play(animation_name)
	else:
		if animations2:
			parent.animations2.play(animation_name)
		else:
			print("wompwomp",animations2)
func exit() -> void:
	pass
func process_input(_event: InputEvent) ->State:
	return null
func process_frame(_delta: float) -> State:
	return null
	
