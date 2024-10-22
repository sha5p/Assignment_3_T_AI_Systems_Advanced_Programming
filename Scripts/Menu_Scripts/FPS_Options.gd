extends Control
@onready var option_button = $HBoxContainer/OptionButton
const FPS_DISPLAY: Array[String] =[
	"15 FPS",
	"30 FPS",
	"60 FPS",
	"120 FPS",
	"240 FPS"
] #Makes a list to display on option button
func _ready():
	_add_option_button()
	option_button.select(2)
	option_button.item_selected.connect(fps_change)
	var fps = SaveSettings.load_frames()
	Engine.max_fps = fps
	if fps ==15:
		fps =0
	if fps ==30:
		fps =1
	if fps ==60:
		fps =2
	if fps ==120:
		fps =3
	if fps ==120:
		fps =4
	option_button.select(fps)
func _add_option_button():
	for option_button_options in FPS_DISPLAY:
		option_button.add_item(option_button_options)
func fps_change(index :int):
	#Uses matach to change fps if an option button is clicked
	match index:
		0: #15FPS
			Engine.max_fps = 15
			SaveSettings.save_frame("Frames",15)
		1: #30 FPS
			Engine.max_fps = 30
			SaveSettings.save_frame("Frames",30)
		2: #60 FPS
			Engine.max_fps = 60
			SaveSettings.save_frame("Frames",60)
		3: #120 FPS
			Engine.max_fps = 120
			SaveSettings.save_frame("Frames",120)
		4: #240 FPS
			Engine.max_fps = 240
			SaveSettings.save_frame("Frames",240)

