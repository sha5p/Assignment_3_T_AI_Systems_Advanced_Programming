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
```
extends State
signal insturction(state)
signal insturction_2(state)
signal Runat(state)
func enter() ->void:
	var nodes_in_group = get_tree().get_nodes_in_group("skeli")
	for node in nodes_in_group:
		node.connect("colliding", Callable(self, "state_func"))
		node.connect("Notcolliding", Callable(self, "RunAt_from_attack"))
```

First diffrent signals were made and connected for the reaper to understand the skeltons situation and control the states of the skeleton. Then depending on this information it would send signals informating the skeleton what to do. 
```  
func process_physics(_delta: float) -> State:
	var nodes_in_group = get_tree().get_nodes_in_group("skeli")
	for node in nodes_in_group:
		if node.position == player.position and command:
			command=false
			Sig_Attack()
		elif node.position != player.position and command:
			command=false
			Sig_RunAt()
	if Global.skeli==0:
		return SearchState
	return null
```
Calling diffrent signal functions these were than connected to to the skeleton in its state machine script and then would be controled based off the informaiton instead of using signals the skeletons could have been a child of the main repeaer node. However this decreases flexiblity and functionalty as it would require more dependecys such as specific refrences to the mob rather than using univesal indicators such as groups would could be incoprated to other mobs much easier if required. 

The skeleton sending signals to the reaper as follows 
```
	if ray_1.is_colliding() or ray_2.is_colliding():

		if ray_1.is_colliding():

			emit_signal("colliding",self) 	
		else:

			emit_signal("colliding",self) 	
	if !ray_1.is_colliding() and !ray_2.is_colliding():
			emit_signal("Notcolliding",self) 	
```

Informing the reaper if its colliding or not and with this information lets it do the above which signals are then connected to the mobs states.
```
r z=true
func enter():
	var first_node = nodes_in_group[0]
	if z:
		first_node.connect("insturction_2", Callable(self, "state_func"))
		z=false
	animation_name = "Run"
	animated_sprite_2d.play("Run")
func process_physics(_delta: float) -> State:
	var players = get_tree().get_nodes_in_group("player")
	var dir = Vector2(players[0].position.x - parent.global_position.x,0)
	dir=dir.normalized()
	parent.velocity.x= dir.x*10
	parent.move_and_slide()
	if Global.current_dimension == "Dimension2":
		return null
	if stateControl == "attack":
		stateControl=""
		return attack
	return null
```
Unlike the reaper who doesnt need to fly this mob will if the reaper commands run at the direction of the player. Then in all scripts as shown above values are returned when the signal connected to it results an emmition. However this only happens if the value in the signal that the reaper returns is itself. What this means is that the mobs are controlled indivdualy increasing the immersion of the user by adding varity for the player. 

Once these mobs have been killed if the dimension is still in 1 than the reaper will go into an attack phase in which it will find the players location and then telport to him to attack. This attack pattern controled through pathfinding and collisions to return an attack state. This attack state will countiue until the player has died the reaper is killed or the dimension is changed. 

If the dimension is changed the reaper will spawn a diffrent mob while attacking. This is because the mob spawned is not controlled by the reaper which has the following state machine. 

##### Big Guy/Mage
A majority of this mob runs off timers and randomizes creating a unqiue and diffrent mob. This mob was designed to be very diffrent to how the other mobs run for instance the mob cannot be killed by the player instead they can only die after the lifetime or the 'timer' has run out what 



#### Main Necromancer AI State Machine 
How hirecy based state machine is used from the player and they talked to allow for information 
#### Signals via state machine 
#### Companion follows
