extends Node
@onready var parallax_background = $ParallaxBackground
@onready var parallax_background_2 = $ParallaxBackground2
@onready var animation_player = $AnimationPlayer

func _physics_process(_delta):
	if Global.current_dimension == "Dimension1":
				parallax_background.visible=true
				parallax_background_2.visible=false
	else:
		parallax_background.visible=false
		parallax_background_2.visible=true
#Change baseed off states
