# Assignment_3(T)-AI_Systems_(Advanced_Programming)
## **Documentation State Machine** 


## **AI State Machine Planning**  

|State Machines|State Machine Design|State Machine Ideas|Flow Chart|
|:-----|:----|:----|:----|
|Canine|![image](https://github.com/user-attachments/assets/2e655cce-5732-4947-8896-bb208d8fc01d)|A simple dog that will be the players companion however the|![image](https://github.com/user-attachments/assets/4d174b96-df33-4e61-95f7-28afc4a7ada3)|
|Necromancer|![image](https://github.com/user-attachments/assets/04a0d844-a61d-4211-8863-d343530bb880)|Spawns other Enimies that will than be controlled by it/not be to attack the palyer or protect him including a skeleton that will be controlled and a big mob that will work by itself and not be controlled by the necromancer|![image](https://github.com/user-attachments/assets/3c245f64-0f12-4a75-a803-3705446960c8)|
|Skele|![image](https://github.com/user-attachments/assets/2fb31969-cf18-42e0-91ac-ceccb39573d9)|This mob is only able to control its status effects decision making is levft up to the player |Above|
|Big Guy||Big mob guy that necro cannot control|Above|
|Player||Has a varity of states and applications that cannot be applied in other dimensions|

For this assigment to excute a powerful State Machine multiple diffrent types where used throughout the game including in he AI, Player and the terrain. For the player was designed around a simple node based state machine along with the terrian that could help provide information to produce an intellgent AI. 

This system would work by childing nodes to the main script and refrencing them in the main code f

### State machine 
A state machine allows for one singular action to be performed and all other actions ignored and bypassed by the parent node. This allows for  easier debugging throughout the game by improving readablity which for the devloper makes creating specfically more complex AI, Players and transisation between animation and other information. This assigment uses state machines to influence the enviorment and enemies via the information the player provides. These enemies will than not only be influenced by the player but by other enemies adding more complextiy and varity for the user. 

#### State Class
```
class_name State
extends Node

@export var animation_name:String
@export var move_speed: float= 400

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var parent: CharacterBody2D
var player: Node2D
var animations:AnimatedSprite2D
func enter() ->void:
		parent.animations.play(animation_name)
func exit() -> void:
	pass
func process_input(_event: InputEvent) ->State:
	return null
func process_frame(_delta: float) -> State:
	return null
```
#### State Machine
![image](https://github.com/user-attachments/assets/e5b5c700-ef26-455b-a073-a32e485210ff)

```
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
```

#### Player State Machine and Script
What player does for state Machine 
Script based state machine 

### State Machine Enemy AI
Basic setup explanation for the state machine here and why it is used
#### Main Necromancer AI State Machine 
How hirecy based state machine is used from the player and they talked to allow for information 
#### Signals via state machine 
#### Companion follows
