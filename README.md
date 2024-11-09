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
A state class is what defines all states if they extend the class the engine will run through and check assign values that are currently stated. The player is extended as this code is modulated for all ChracterBody2Ds this means that player does not have to been defined in the player but a refrence to it can be made in the enemy script. Next an animation node is added so that when each state is entered the assigned animation node will be played without constant defintion though this does not play if there is more than one animation defined for smaller state machines this system is used. 

#### State Machine
![image](https://github.com/user-attachments/assets/e5b5c700-ef26-455b-a073-a32e485210ff)
A state machine rather than being made for each script is made as a scene as uses refrences to make it modulable over each scene. First exports are deefined as somthing that extends the state class so that only states can be made a refrence to. Then a varity of scripts are used to allow a smooth transisation between the states.
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
The player runs of 3 diffrent state machines which all control diffrent aspects of the game and inturn affect the user. The include a state machine for attacks, movment and dimension changing. Both the movment and attacks run off the state machine and class above while the dimension changer uses a state machine script. 

Two diffrent state machines for the player were used as it allowed for multiple functions to run at the same time while still incoprating a state machine. Both of these were than connected to the player and initalised. These include that of the attack state machine and the movment state machine 
![image](https://github.com/user-attachments/assets/d2e5d06a-dca5-42b0-8551-c850d6ca08d5)

both in which operating indivdually the attack state machine animations being run in a higher hirecy so animations dont overlap. It was designed using multiple state machines as it allowed for two things two occur on the player at once that being attacking and movment. Alternativly both the attack and state machine could have run under the same state machine however controlling what is occuring would of had an overlap of functions such as movment code in an attack script. 

The script based state machine running off the following code.
```
enum Dimension { Dimension1, Dimension2 }
var current_dimensions = Dimension.Dimension1
func _ready(): 
	change()
func change_dimension(new_dimension):
	current_dimensions = new_dimension
	change()
func change()->void:
	match current_dimensions:
		Dimension.Dimension1:
			current_dimension="Dimension1"
		Dimension.Dimension2:
			current_dimension="Dimension2"
```
By running this script through an autoloader it allows the dimension to be controlled independent to the scene. However the player can still influence the current state that the player is in. This means that adding another dimension can just be implmented via adding simply enuming the information can be performed and other information can be changed overtime this is because changing or adding a dimension does not cause dependcys. This could have been an addtionaal state to the player however upon testing storing the infromation in this state is more compact and controlling inputs for the user would have less dependencys.

### State Machine Enemy AI
To set up the state machines of the main mob or repeaer mob some system needs to be implmented for the current dimension that is being run. The two ways that this can be done is like the player running off two diffrent state machines depending on the dimension or adding addtional hirecy. Because unlike the player running diffrent states at the same time would simply cause bug like playablity and so the use of hirecy state machines was used. This state machine is the same as others except it goes through a hirecy if the function tree() is present. 

```
if child.has_method("tree"):
			for sub_child in child.get_children():
				sub_child.parent=parent
				sub_child.animations=animations
				sub_child.player=player
```

Looping through and adding those to the hirecy as shown. 
![image](https://github.com/user-attachments/assets/bdc59c03-03fa-4089-94d2-92a4477651fd)

This mob then incoprates path finding by using a navigation agent 2D. Which was done for complex movment for future additions to the game such as obstucles. By getting a refrence to the player and using this inbuilt system the path could be made. 
```
func _makepath() ->void:
	nav_agent.target_position=player.global_position
func _on_timer_timeout() ->void:
	_makepath()
```

Rather than using a customized pathfinding system using godot prebuiilt function allowed for the same functionallty in the short timespawn given for the assesment. 

Then along with movment there were two diffrent mobs that could be summoned that were shown in the planning above which in include a big mob and a skeltons.

##### Skelton Mob and Reaper Control


##### Big Guy/Mage
#### Main Necromancer AI State Machine 
How hirecy based state machine is used from the player and they talked to allow for information 
#### Signals via state machine 
#### Companion follows
