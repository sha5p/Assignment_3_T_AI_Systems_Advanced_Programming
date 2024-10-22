extends Control
@onready var option_button = $HBoxContainer/OptionButton


const WINDOW_MODE_ARRAY: Array[String] =[
	"Window Mode",
	"Full-screen",
	"Borderless Window",
	"Borderless Full-Screen"
] #Sets the string the the options 
func _ready():
	_add_option_button()
	option_button.item_selected.connect(window_selected)
	var video_setting = SaveSettings.load_video_setting()
	#Checks savee states have a save if so load it
	for settings in video_setting:
		if video_setting[settings] ==true:
			if settings == "Window Mode":
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
				DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
				option_button.select(0)			
			if settings == "Full-screen":
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
				DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
				option_button.select(1)
			if settings == "Borderless Window":
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
				DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
				option_button.select(2)
			if settings =="Borderless Full-Screen":
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
				DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
				option_button.select(3)
			else:
				pass
func _add_option_button():
	#Shows the options in option button
	for option_button_options in WINDOW_MODE_ARRAY:
		option_button.add_item(option_button_options)
func window_selected(index :int):
	#Mataches the settings to the saves setting
	match index:
		0: #Widow mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			SaveSettings.save_video_setting("Window Mode",true)
			SaveSettings.save_video_setting("Full-screen",false)
			SaveSettings.save_video_setting("Borderless Window",false)
			SaveSettings.save_video_setting("Borderless Full-Screen",false)
		1: #full screen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			SaveSettings.save_video_setting("Window Mode",false)
			SaveSettings.save_video_setting("Full-screen",true)
			SaveSettings.save_video_setting("Borderless Window",false)
			SaveSettings.save_video_setting("Borderless Full-Screen",false)
		2: #Borderless window
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			SaveSettings.save_video_setting("Window Mode",false)
			SaveSettings.save_video_setting("Full-screen",false)
			SaveSettings.save_video_setting("Borderless Window",true)
			SaveSettings.save_video_setting("Borderless Full-Screen",false)
		3: #Borderless full Screen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			SaveSettings.save_video_setting("Window Mode",false)
			SaveSettings.save_video_setting("Full-screen",false)
			SaveSettings.save_video_setting("Borderless Window",false)
			SaveSettings.save_video_setting("Borderless Full-Screen",true)
