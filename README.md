# Assignment_3(T)-AI_Systems_(Advanced_Programming)
## **Documentation State Machine** 


## **Planning & Design the Game**  

|State Machines|State Machine Design|State Machine Ideas|Flow Chart|
|:-----|:----|:----|:----|
|Canine|![image](https://github.com/user-attachments/assets/2e655cce-5732-4947-8896-bb208d8fc01d)|A simple dog that will be the player's companion|![image](https://github.com/user-attachments/assets/4d174b96-df33-4e61-95f7-28afc4a7ada3)|
|Necromancer|![image](https://github.com/user-attachments/assets/04a0d844-a61d-4211-8863-d343530bb880) [FullSize](https://drive.google.com/file/d/1xt8LRz3Qd71guFAARDDSh-HFdyelsfbL/view?usp=sharing)|Spawns other enemies control some of the enemies it spawns while others are independent rather than having different states such as attack, search and retreat.|![image](https://github.com/user-attachments/assets/3c245f64-0f12-4a75-a803-3705446960c8)|
|skeleton|![image](https://github.com/user-attachments/assets/2fb31969-cf18-42e0-91ac-ceccb39573d9)|A mob that is reliant on the reaper and will only switch states when the reaper commands it.|![image](https://github.com/user-attachments/assets/7f5b1c4d-0ccf-4b2f-8b05-299a33e38f08)|
|Big Guy|![image](https://github.com/user-attachments/assets/9ce41ef9-db49-40db-8f58-a65e51ead873)|Big mob that is independent and will have a variety of unique functions not seen often in mobs. Though it still must be spawned by the reaper its actions are not defined by it|![image](https://github.com/user-attachments/assets/ba2a6c41-47fd-4a43-95b6-cf60230031f8)|
|Player|![image](https://github.com/user-attachments/assets/708d1d0e-8860-4504-b027-c170609ea9ce)![image](https://github.com/user-attachments/assets/f973550a-71b8-4ec3-8b8a-2b3f7dbd20fc)|This player should be intended to contain a unique design making the base gameplay of the game reliant on its states. This main focus is dimensioned in which the main boss's decisions are changed by the player's current dimension.|![image](https://github.com/user-attachments/assets/23be733b-b924-43e8-8ea1-d8518f6d6b1f)|

### **Concept**  
For this assignment to execute a powerful State Machine a game that has this in focus was designed. This means that the core ability of the player is to change ‘states’ or dimensions. To do this AI will be designed to change states using a ‘state machine’ with decision tree properties for dimension handling. 

## State machine 
The State Machine designed for this assessment allows for a single action or script that extends the state to run ignoring other code in other scripts that return States. This design, unlike the usual state machine, means that scripts not in the current state can run if they don’t return a State value. Though the original type of state machine is powerful this design allows for more flexible code while maintaining the original functionality of a state machine. Allowing for an easier debugging process throughout the game by improving readability for the developer to design complex AI, player animations ect. 

### State Class
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
A state class is what was used to be referenced in all state machines. Functions returning states are only useful if the current state is in use. As explained above this was done for more flexibility in the code and adding features that I want to be present at all times. However, this does not have a reference to any script because it is the base class instead a class is made to be referred to following this blueprint. These include a player, parent and animations. For all state machines, a reference to the parent is important as it allows for the top of the heresy to be controlled in a lower hierarchy node. However Important for the AI especially those that are summoned is a way to still reference the player as they cannot be initially made if not both present in the scene.



### State Machine modulated
A state machine rather than being made for each script is made as a scene for the reuse of code. 

![image](https://github.com/user-attachments/assets/e5b5c700-ef26-455b-a073-a32e485210ff)

For modularity the script needed to set references using exports and referencing these exports to assign states. 
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
```
This method is what allowed for the reuse of code making it more time efficient but also decreased how flexible the code was and its ability to target the specific scene. Then a system was made for returning states so that when a value is returned the state would change to the new state.
```
func change_state(new_state: Node) -> void:
	if current_state:
		current_state.exit()
	current_state=new_state
	current_state.enter()
func process_physics(delta: float) -> void:
	var new_state =current_state.process_physics(delta)
	if new_state:
		change_state(new_state)
```
By using this method and calling the current state enter and exit. These functions as shown in the above [state class](https://github.com/sha5p/Assignment_3_T_AI_Systems_Advanced_Programming?tab=readme-ov-file#state-class) do not return the State being called once every time allowing for a similar function to the ready function happening when the state is exited and entered. Though unnecessary these applications could be expanded upon in the future to form decision trees in which the exit and enter require dependency or information before going further into the tree.

### Player State Machine and Script 

The player runs 3 different state machines which control different aspects of the player requiring these multiple states at the same time. They include a state machine for attacks, movement and dimension changing. Both the movement and attacks run off the modulated state machine and class while the dimension changer uses a state machine script. So for the player, two different state machine scenes were connected/instantiated to the player as shown below.

![image](https://github.com/user-attachments/assets/d2e5d06a-dca5-42b0-8551-c850d6ca08d5)
![image](https://github.com/user-attachments/assets/012da2ec-dc78-4ee7-bc03-3600d5e26fa5)

Originally a more customised state machine was made to run two different states at the same time allowing the return of two different classes. However, the method proved inefficient supporting a [modulated](https://github.com/sha5p/Assignment_3_T_AI_Systems_Advanced_Programming?tab=readme-ov-file#state-machine-modulated) State machine initially designed and so was used throughout. This lets two different things occur at the same time in the player with the use of hierarchy to ensure the correct animation. The other machine not directly attached to the player being script-based as an autoloader functioning as shown below


The script-based state machine runs off the following code.
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
Running a script-based state machine requires an enum that can easily be switched and through an autoloader allows the dimension to be controlled independently of the scene. However, this machine still influences the state of the player. Depending on input the dimension is changed and the functionality of the player along with it. This includes the ability of the player to jump
```
if Input.is_action_just_pressed("Up") and parent.is_on_floor() and Global.current_dimension == "Dimension1":
		parent.velocity.y = JUMP_VELOCITY
```
And what the player looks like visually to the user. 

![image](https://github.com/user-attachments/assets/59107f11-4732-439a-9ec9-afc20d989d28)
![image](https://github.com/user-attachments/assets/901d504f-1175-4b84-b213-9b502f43ff15)

This could have also been used as a state machine but as this information is used throughout the script an autoloader seemed preferable. 

#### Environment  
Additionally, the use of the enum operating individually lets it easily communicate with environment scripts which then change the dimension depending on the information. Immersing the user and letting them know to expect and different outcome because of the dimension change. 
|Diemension 1|Dimension 2|
|:-----|:----|
|![image](https://github.com/user-attachments/assets/25ea02c1-b269-40f9-bea5-3db0151ed448)|![image](https://github.com/user-attachments/assets/682dd714-b701-4f84-b877-78caf640de21)|

### State Machine Enemy AI
To set up the state machines of the reaper mob a system for the current dimension needed to be made. The two ways that this could have been done are through multiple state machines or a decision tree method requiring a dimension for the next operation. Unlike the player's ability to run different states at the same time, testing suggested that this method was more bug-prone as it did not ensure a singular state. And so changes to the [state machine](https://github.com/sha5p/Assignment_3_T_AI_Systems_Advanced_Programming?tab=readme-ov-file#state-machine-modulated) were made.
```
if child.has_method("tree"):
			for sub_child in child.get_children():
				sub_child.parent=parent
				sub_child.animations=animations
				sub_child.player=player
```

Looping through and adding those to first child states with the tree function present to look lower in the hierarchy and add those with ‘States’ as a state. 

![image](https://github.com/user-attachments/assets/bdc59c03-03fa-4089-94d2-92a4477651fd)


![image](https://github.com/user-attachments/assets/9b284f9c-c743-466b-820b-813dfcc09dbe)![image](https://github.com/user-attachments/assets/c87a7ce4-cb6a-48da-be32-47b2f6d1e32e)

#### Path Finding
This mob then incorporates pathfinding by using a navigation agent 2D to locate the player. Which allows for smooth movement to go to the player even if obstacles are present. By getting a reference to the player and using this inbuilt system the path to the player could be made. 
```
func process_physics(_delta: float) -> State:
	var dir =parent.to_local(nav_agent.get_next_path_position()).normalized()
	parent.velocity=dir*speed
	parent.move_and_slide()
func _makepath() ->void:
	nav_agent.target_position=player.global_position
func _on_timer_timeout() ->void:
	_makepath()
```

Rather than using a customized pathfinding system using godot prebuilt function allowed for the same functionality in the short timespan given for the assessment. Additionally, this navigation means obstacles and other forms of blockage against the mob could be added without damaging the AI's ability to locate the player 

Then if the reaper got close enough to the player depending on the dimension two different mobs could be summoned. 

#### Skeleton Mob and Reaper Control
For the first mob, the skeleton all decisions of its actions were made by the reaper the only thing the skeleton did was inform the reaper of its current posistion and if ray casts were colliding. 
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

First different signals were made and connected for the reaper to understand the skeleton's situation and control the states of the skeleton. Then depending on this information it would send signals informating the skeleton what to do. 
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
Different signals were then connected to the skeleton in its state machine script and then would be controlled based on the information. The reason the skeleton was not a direct child of the reaper was because this created a variety of movement issues in the skeleton while the reaper moved. Which was why signals were used instead though this decreases flexibility it decreases the amount of dependencies needed for the code. 

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

Informing the reaper if it is colliding or not and with this information it gives those above commands such as Sig_Attack() to attack the player. 

#### Skeleton pathfinding
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
Unlike the reaper, this mob doesn't need to fly and so instead goes directly to the player when told to. What's important about the method used for controlling the reaper is that the skeletons emit themselves as a signal only the individual skeleton is controlled not the whole group increasing the immersion of the user by adding varity for the player. 

Once these mobs have been killed if the dimension is still in 1 then the reaper will go into an attack phase in which it will find the player's location and then teleport to him to attack. This attack pattern is controlled through pathfinding and collisions to return an attack state. 

![image](https://github.com/user-attachments/assets/82a3a2f7-3ccf-4910-b8b1-3c0a5bb6e7b1)

This attack state will countiue until the player has died the reaper is killed or the dimension is changed. 

If the dimension is changed the reaper will spawn a different mob while attacking. This is because the mob spawned is not controlled by the reaper and so this is what 'allows' the reaper to attack while the other mob is present. 

#### Big Guy/Mage
A majority of this mob runs off-timers and randomizes creating a unique and different mob. This mob was designed to be very different to how the other mobs. For instance, the mob cannot be killed by the player instead they can only die after the lifetime or the 'timer' has run out. The states of the timer are controlled as follows

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

On the mob, a few timers are set the main concept being that the mob will die once a timer runs out and this timer works through each state machine because of the design above. An await function is not being used and instead a timer is due to the error ‘async function without "await" in which suggestions suggest it to be a version issue. 

![image](https://github.com/user-attachments/assets/53dc38a4-4c62-49b7-b790-185fdc27c87a)
Instead of incorporating the timer function throughout the state machine, it could have been used at the top of the hierarchy. However, the abundance of timer nodes used in this mob running through using a state machine makes us of functions designed earlier while slightly decreasing code lines. 

The mob shoots the player quickly due to its death being based on a timer. This is done by changing states through a ray cast. However, the group assigned to this ray cast means that it can hit the reaper mob as well adding more strategy and depth for the player.



The movement of this mob was designed to be less predictable by running on a random function to decide which direction it could move in 
```
func change_direction():
	direction = randf_range(-1, 1)


func _on_timer_2_timeout():
	if parent.velocity.x != 0:
		change_direction()
```

On this timer when ended the direction the mob is moving in would change or stay the same depending on the random function result. However, upon reflection on this code, randomising speed as well as the y value could have given another layer of 'randomness' to the user.   

### Testing and feedback

The main struggle was finding a way to control the skeleton's mobs individually. This was because a varity of solutions such as making it part of the reaper mob or making both of them their scenes lacked reliability. Other methods such as relying on information through global variables or signalling information became dependent on specific parts of the code. And so a varity of tests were made to find the least dependent way to refer to the mob/skeleton. 

By looping through the skeletons as a group an individual reference could made for each skeleton. However, this did not work as the reaper did not know which skeleton was doing which action only the actions occurring were in one of those in the group. To solve this the signals emitted by the skeleton emitted themselves so that the reaper had a reference. Allowing them to be controlled individually instead of as a group.

![image](https://github.com/user-attachments/assets/37d5c98c-a3bb-4434-8705-2728ff12950a)

Taking this request from the user the combat system was improved by adding a cancel to the skeleton attack if hit.


![image](https://github.com/user-attachments/assets/1b388c04-cd75-49d3-b3ed-21c354f7ab70)

This was done by running the animation through a function that doesn't go through the -> States allowing it to bypass the current animation being played which is why damage taken is not a state in any other mob built upon this system. If given more time additional additions such as hit stop would have been added but time constraints only allowed for this issue to be partially addressed. 

The second test user asked for the addition of indications when the reaper would attack next and so a radius was added to the reaper to show how far it could see. 

![image](https://github.com/user-attachments/assets/9ef2280d-de7e-4f8e-b41c-5ccb5b5fedd6)

This addition also improved upon the combat like the first user asked for as well as solving the initial problem. 

Lastly, the final user asked for indications that the reaper was controlling the skeleton mob through symbols. 
![image](https://github.com/user-attachments/assets/d9b95ba8-b901-4808-b45c-41216aab25db)

![image](https://github.com/user-attachments/assets/6338cdc5-6a8f-4fb0-8255-a98a324eb394) 
![image](https://github.com/user-attachments/assets/d244083e-380c-433c-ba0c-a5f3d3d9add1)





### Evaluation on Game

Unlike other games before this one had a heavy focus on State Machines. In future, I wish to polish games, improving upon basic features while completing all that was first planned such as the companion mob that could not be done. However, generally, it seemed that the user enjoyed the game as shown in the graph here and through the user's responses.

![image](https://github.com/user-attachments/assets/05c73990-2a35-44ca-8af6-e307b09fdcb0)





## Bibliography 
Alex (2016). How to make an sprite bounce within an object? [online] Stack Overflow. Available at: https://stackoverflow.com/questions/38216878/how-to-make-an-sprite-bounce-within-an-object.[Accessed 9 Nov. 2024].

itch.io. (2022). Animation Dark Character. [online] Available at: https://darkknight17.itch.io/eee [Accessed 23 Nov. 2024].

itch.io. (2024). Free Magic Summons Pack. [online] Available at: https://srzolda.itch.io/magic-summons [Accessed 26 Oct. 2024].

itch.io. (n.d.). Free Horizontal Game Backgrounds by Free Game Assets (GUI, Sprite, Tilesets). [online] Available at: https://free-game-assets.itch.io/free-horizontal-game-backgrounds.[Accessed 25 Nov. 2024].

‌
‌itch.io. (n.d.). Boss: Undead Executioner [FREE] by Kronovi-. [online] Available at: https://darkpixel-kronovi.itch.io/undead-executioner.[Accessed 25 Nov. 2024].

‌
itch.io. (2024). Blood Demons. [online] Available at: https://immortal-burrito.itch.io/blood-demons [Accessed 8 Nov. 2024].

‌
itch.io. (2024). Undead Sprite Pack. [online] Available at: https://finalgatestudios.itch.io/undead-sprite-pack [Accessed 1 Nov. 2024].

oOsongOo (2024). background music | Royalty-free Music. [online] Pixabay.com. Available at: https://pixabay.com/sound-effects/background-music-224633/ [Accessed 11 Nov. 2024].

‌Pixabay (2023). lift music by kk | Royalty-free Music. [online] Pixabay.com. Available at: https://pixabay.com/sound-effects/lift-music-by-kk-30497/ [Accessed 11 Nov. 2024].

‌
