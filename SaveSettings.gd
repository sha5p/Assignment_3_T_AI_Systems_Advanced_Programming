extends Node
const SETTING_SAVE= "user://setting.ini"
var config = ConfigFile.new()
func _ready():
	SaveData.save_data()
	#If file does not excsit create one
	if !FileAccess.file_exists(SETTING_SAVE):
		config.set_value("keybinding","Left","A")
		config.set_value("keybinding","Right","D")
		config.set_value("keybinding","Attack","J")
		config.set_value("keybinding","Up","W")
		config.set_value("keybinding","Change Dimension","K")
		config.set_value("keybinding","Pause","Escape")
		
		
		config.set_value("audio","Master",1.0)
		config.set_value("audio","Music",1.0)
		config.set_value("audio","SFX",1.0)
		
		config.set_value("video","Window Mode",true)
		config.set_value("video","Full-screen",false)
		config.set_value("video","Borderless Window",false)
		config.set_value("video","Borderless Full-Screen",false)
		
		config.set_value("video_FPS","Frames",60)
		config.save(SETTING_SAVE)
	else:
		#If file excists load the file
		#config.save(SETTING_SAVE)
		config.load(SETTING_SAVE)
func save_keybinds(action:StringName,event: InputEvent):
	#Takes in values to save keybind 
	var event_str
	if event is InputEventKey:
		event_str = OS.get_keycode_string(event.physical_keycode)
		config.set_value("keybinding",action,event_str)
		config.save(SETTING_SAVE)
	
func key_load():
	#Makes a list for a config that contain keybinding to load
	var keybindings={}
	var keys = config.get_section_keys("keybinding")
	for key in keys:
		var input_event 
		var event_str = config.get_value("keybinding", key)
		if event_str.contains("mouse_ "):
			input_event = InputEventMouseButton.new()
			input_event.button_index=int(event_str.spl.split("_")[1])
		else:
			input_event = InputEventKey.new()
			input_event.keycode = OS.find_keycode_from_string(event_str)
			
		keybindings[key] = input_event
	return keybindings
	
func save_audio_setting(key: String, value):
	#takes the value for audio depending on a VALUE which is linked to slide
	config.set_value("audio",key,value)
	config.save(SETTING_SAVE)
func audio_load():
	#Same as key load list
	var audio_setting={}
	for key in config.get_section_keys("audio"):
		audio_setting[key] = config.get_value("audio", key)
	return audio_setting
func save_video_setting(key: String, value):
	#takes a value from when the function called same
	config.set_value("video",key,value)
	config.save(SETTING_SAVE)
func load_video_setting():
	#list same as above
	var video_setting={}
	for key in config.get_section_keys("video"):
		video_setting[key] = config.get_value("video",key)
	return video_setting
func save_frame(key: String, value):
	#Same as above
	config.set_value("video_FPS",key,value)
	config.save(SETTING_SAVE)
func load_frames():
	#Same as above
	var frame_amount ={}
	frame_amount=config.get_value("video_FPS","Frames")
	return frame_amount
