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

### Invorment 
Addtionally the use of the enum operating indivdually lets it easily comminicate with enviorment scripts which than change the dimension depending on the information. Immersing the user and letting them know to expect and diffrent outcome because of the dimension change

|Diemension 1|Dimension 2|
|:-----|:----|
|![image](https://github.com/user-attachments/assets/25ea02c1-b269-40f9-bea5-3db0151ed448)|![image](https://github.com/user-attachments/assets/682dd714-b701-4f84-b877-78caf640de21)|

The would also change the player based on the dimension in one a 'lighter' stickman which can jump around and in the other a more beefed up mob which though cannot jump has less obsticles and enemys to fight.
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
A majority of this mob runs off timers and randomizes creating a unqiue and diffrent mob. This mob was designed to be very diffrent to how the other mobs run for instance the mob cannot be killed by the player instead they can only die after the lifetime or the 'timer' has run out. The states of the timer are controlled as follows


```
func process_physics(_delta: float) -> State:
	if death:
		return death_state
	if attack:
		attack=false
		return Relax_State
	return null
func _process(_delta: float) -> void:
	pass
func _on_timer_timeout():
	death=true
func _on_attack_finished_timeout():
	attack =true
```

On the mob a few timers are set the main concept though is that the mob will die once a timer runs out and this timer works through each state machine so no matter what function it is operating on it will die after a span of time. However the way this mob deals damage to the player is somthing that is hard to avoid accounting for what may have been an easy experience. Instead of incoprating the timer function throughout the statmachine it couold have been used at the top of the hirecy. However because of the abudence of timer nodes used in this mob running though using a state machine in this way signifcantly reduces what has to be done deisgned for this mob. 

The attack function using raycasts like the skeleton mob however running by itself and shooting at whaever is casted to it. This raycast can however hit the reaper mob and deal damage to it adding more depth and stratgey for the player if they so choose. 



The movment of this mob was also designed to be less predictble running on a randoom function to decide which direction it can move in 
```
func change_direction():
	direction = randf_range(-1, 1)


func _on_timer_2_timeout():
	if parent.velocity.x != 0:
		change_direction()
```

On this timer when ended the direction the mob is moving in would change or stay the same depending on the random function result. 

### Testing and feedback

The first inital struggle was finding a way to control the skeletons mobs individually. This was because a varity of solutions such as making it part of the reaper mob or making both of them their own scenes were iniffcent. Other methods such as relying information through global varibles for signling information became dependent on specific parts of code. And so a varity of tests were made in the best way to make a refrence to the mob. the first method used was looping through the skeletons as a group and finding a refrence then comanding each indivdually. However this did not work as it did not know which skeleton was doing which action only the signals emmiting. And so to solve this the signals emmited by the skeleton emmited themselves along so that the reaper had a refrence. Allowing them to be controlled individully instead of as a group.

Feedback from users suggested a few diffrent incoprations to improve upon the came. The first suggested to improve upon the player and its 'sluggish' movment along with how the combat felt.

![image](https://github.com/user-attachments/assets/37d5c98c-a3bb-4434-8705-2728ff12950a)

taking in on request from the user the combat system was improve upon adding a cancel to the skeletons attack if hit.

![image](https://github.com/user-attachments/assets/1b388c04-cd75-49d3-b3ed-21c354f7ab70)

This was done by running the animation through a function that doesnt go through the -> States allowing it to bypass the current animation being played which is why damage taken is not a state in any other mob a built upon this system. 


The second test user asked for the addition of indications the the when the reaper would attack next and so a radius was added to the reaper to show how far it could see 

![image](https://github.com/user-attachments/assets/9ef2280d-de7e-4f8e-b41c-5ccb5b5fedd6)

Which not only improved upon the combat like the first user asked for but solved the problem of a lack of being able to predict where the mob could go. 

Lastly the final user asked for indications that the reaper was controling the skeleton mob 
![image](https://github.com/user-attachments/assets/d9b95ba8-b901-4808-b45c-41216aab25db)
and so the use of the same animation of 'rune like' symbol was used when controling the skeleton mob 

![image](https://github.com/user-attachments/assets/6338cdc5-6a8f-4fb0-8255-a98a324eb394) 
![image](https://github.com/user-attachments/assets/aea86275-543c-4ae5-9bbf-bd90610d58ba)
![image](https://github.com/user-attachments/assets/30b03fe2-2857-4d49-8540-7a7e79b76f1a)
However generally it seemed that the user enjoyed the game as shown in the grapth here and through the users responses

![image](https://github.com/user-attachments/assets/05c73990-2a35-44ca-8af6-e307b09fdcb0)

### Evulation on Game

Unlike other games before this one had a heavy focus on enemey AI and state machine design. This game using a varity of state machines to perform spercific functions including that of controling other mobs, complex enemy states, controling the player and script based state machines. If this assesment were to have been extended polishing on the state machines and taking full advantage of its function to devlop more complex scripts would have been used on more of the mobs rather than just the reaper. In addition adding polish such as a hit stop to the player so the user feels more impact as well as explore more into changing the enviorment and making the dimension feature even more imbended into the game such as parcore routes that can only be taken in one dimension. 
