extends Control
@onready var label = $HBoxContainer/Audio_type2 as Label
@onready var h_slider = $HBoxContainer/HSlider as HSlider
@onready var audio_sound_level = $HBoxContainer/Audio_sound_level as Label

@export_enum("Master","Music","SFX") var bus_name : String
#Exports three optional strings for busses 
var bus_index: int = 0

func _ready():
	#Loads volume save
	var audio_save = SaveSettings.audio_load()
	get_busname()
	h_slider.value_changed.connect(on_value_changed)
	var saved_volume_db = audio_save[bus_name]
	#AudioServer.get_bus_volume_db(saved_volume_db)
	# Check if the bus_name exists in the saved settings and set the slider value
	set_audio_name()
	_sliderValue()
	if bus_name in audio_save:
		h_slider.value = (saved_volume_db*100)
func set_audio_name():
	label.text =str(bus_name)+" Volume"
	
func on_value_changed(value: float):
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	audio_text_volume()
	
func audio_text_volume():
	#Displays h values value
	audio_sound_level.text =str(h_slider.value*100) +"%"
func _sliderValue():
	h_slider.value =db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	audio_text_volume()
func get_busname():
	bus_index = AudioServer.get_bus_index(bus_name)





func _on_h_slider_drag_ended(_value):
	pass
	SaveSettings.save_audio_setting(bus_name,h_slider.value/100)
