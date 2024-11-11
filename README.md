# Assignment_3(T)-AI_Systems_(Advanced_Programming)
## **Documentation State Machine** 


## **Planning & Design the Game**  

|State Machines|State Machine Design|State Machine Ideas|Flow Chart|
|:-----|:----|:----|:----|
|Canine|![image](https://github.com/user-attachments/assets/2e655cce-5732-4947-8896-bb208d8fc01d)|A simple dog that will be the player's companion|![image](https://github.com/user-attachments/assets/4d174b96-df33-4e61-95f7-28afc4a7ada3)|
|Necromancer|![image](https://github.com/user-attachments/assets/04a0d844-a61d-4211-8863-d343530bb880) [FullSize](https://drive.google.com/file/d/1xt8LRz3Qd71guFAARDDSh-HFdyelsfbL/view?usp=sharing)|Spawns other enemies controlling some of the enemies it spawns while others are independent than having different states such as attack search and retreat. |![image](https://github.com/user-attachments/assets/3c245f64-0f12-4a75-a803-3705446960c8)|
|skeleton|![image](https://github.com/user-attachments/assets/2fb31969-cf18-42e0-91ac-ceccb39573d9)|A mob that is reliant on the reaper and will only switch states when the reaper commands it.|![image](https://github.com/user-attachments/assets/7f5b1c4d-0ccf-4b2f-8b05-299a33e38f08)|
|Big Guy|![image](https://github.com/user-attachments/assets/9ce41ef9-db49-40db-8f58-a65e51ead873)|Big mob that is independent and will have a variety of unique functions not seen often in mobs. Though it still must be spawned by the reaper its actions are not defined by it|![image](https://github.com/user-attachments/assets/ba2a6c41-47fd-4a43-95b6-cf60230031f8)|
|Player|![image](https://github.com/user-attachments/assets/708d1d0e-8860-4504-b027-c170609ea9ce)![image](https://github.com/user-attachments/assets/f973550a-71b8-4ec3-8b8a-2b3f7dbd20fc)|This player should be intended to contain a unique design making the base gameplay of the game reliant on its states. This main focus is dimensioned in which the main boss's decisions are changed by the player's current dimension.|![image](https://github.com/user-attachments/assets/23be733b-b924-43e8-8ea1-d8518f6d6b1f)|

### **Concept**  
For this assignment to execute a powerful State Machine a game that has this in focus was designed. This means that the core ability of the player is to change ‘states’ or dimensions. To do this AI will be designed to change states using a ‘state machine’ with decision tree properties for dimension handling. 

## State machine 
The State Machine designed for this assessment allows for a single action or script that extends the state to run ignoring other code in other scripts that return States. This design unlike the usual state machine means that scripts not in the current state can run if they don’t return a State value. Though the original type of state machine is powerful this design allows for more flexible code while maintaining the original functionality of a state machine. Allowing for an easier debugging process throughout the game by improving readability for the developer to design complex AI, player animations ect. 

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
A state class is what was used to be referenced in all state machines. Functions returning states are only useable if the current state is in use. As explained above this was done for more flexibility in the code and adding features that I want to be present at all times. However, this does not have a reference to any script because it is the base class instead a class is made to be referred to following this blueprint. These include a player, parent and animations. For all state machines, a reference to the parent is important as it allows for the top of the heresy to be controlled in a lower hierarchy node. However Important for the AI especially those that are summoned is a way to still reference the player as they cannot be initially made if not both present in the scene.


### State Machine modulated
A state machine rather than being made for each script is made as a scene for moduablity as it allows for the reuse of code. 

![image](https://github.com/user-attachments/assets/e5b5c700-ef26-455b-a073-a32e485210ff)

For modublity the script needed to set refrences using exports and referencing these exports to assign states. 
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
This method is what allowed for the reuse of code making it more time efficent but also decreased how flexible the code was and its ablity to target the specific scene. Then a system was made for returning states so that when a value is returned the state would change to the new state.
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

The player runs 3 different state machines which control different aspects of the player requiring these multiple states at the same time. They include a state machine for attacks, movement and dimension changing. Both the movement and attacks run off the modulated state machine and class while the dimension changer uses a state machine script. So for player two diffrent state machine scenes were connected/instansiated to the player as shown below.

![image](https://github.com/user-attachments/assets/d2e5d06a-dca5-42b0-8551-c850d6ca08d5)

Orginally a more customize state machine was made to run two diffrent states at the same time allowing the return of two diffrent classes. However the method proved iniffcent supporting a [modulated](https://github.com/sha5p/Assignment_3_T_AI_Systems_Advanced_Programming?tab=readme-ov-file#state-machine-modulated) State machine initally designed and so was used throughout. This let two diffrent things occur at the same time in the player with the use of hirecy to insure the correct animation. 

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





### Biblogaphy 
