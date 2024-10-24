extends Node
@export var starting_state:State
@export var current_state: State
# Called when the node enters the scene tree for the first time.

func init(parent:CharacterBody2D, animations:AnimatedSprite2D,player: Node2D) -> void:
	for child in get_children():
		child.parent=parent
		child.animations=animations
		child.player=player
		if child.has_method("tree"):
			for sub_child in child.get_children():
				sub_child.parent=parent
				sub_child.animations=animations
				sub_child.player=player
	change_state(starting_state) 	
func change_state(new_state: Node) -> void:
	if current_state:
		current_state.exit()
	current_state=new_state
	current_state.enter()
func process_physics(delta: float) -> void:
	var new_state =current_state.process_physics(delta)
	if new_state:
		change_state(new_state)
func process_input(event: InputEvent) ->void:
	
	#var z:String
	#if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		#z="Move"
	#if Input.is_action_just_pressed("Up"):
		#z="Jump"
	var new_state= current_state.process_input(event)
	if new_state:
		change_state(new_state)
func process_frame(delta: float) ->void:
	var new_state= current_state.process_frame(delta)
	if new_state:
		change_state(new_state)

