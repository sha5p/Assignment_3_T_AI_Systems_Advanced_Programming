class_name Rebind_Button
extends Control
@onready var label = $HBoxContainer/Label
@onready var button = $HBoxContainer/Button
@export var action_name : String = ""
func _ready():
	set_process_unhandled_key_input(false)
	set_label()
	changing()
	
func set_label():
	#Matches the label to the exported label so all are one scene
	label.text="Unassigned"
	match action_name: 
		"Left":
			label.text = "Move Left"
		"Right":
			label.text ="Move Right"
		"Up":
			label.text="Move Up"
		"Change Dimension":
			label.text="Change Dimension"
		"Pause":
			label.text="Pause"
		"Attack":
			label.text="Attack"
func changing():
	#Changes the button to the input
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var keybind = OS.get_keycode_string(action_event.physical_keycode)
	button.text = "%s" % keybind
	check_keybind_match(action_name, action_event)
	#SaveSettings.update_button_text()
	
func check_keybind_match(action_name, action_event):
	#Changes the key on the input map
	
	# Get the string representation of the physical keycode from the event
	var keybind = OS.get_keycode_string(action_event.physical_keycode)
	
	# Get the string representation of the keycode from the configuration
	var config_keybind = SaveSettings.config.get_value("keybinding", action_name)
	
	if keybind == config_keybind:
		#print("The keybind for action '%s' matches the configuration." % action_name)
		return true
	else:
		button.text =config_keybind
		print("The keybind for action '%s' does not match the configuration." % action_name)
		return false
	
	
	

func _on_button_toggled(toggled_on):
	if toggled_on:
		button.text = "Change Keybind ..."
		set_process_unhandled_key_input(toggled_on)
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name!=self.action_name:
				i.button.toggle_mode = false
				i.set_process_unhandled_key_input(false)
	else:
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name!=self.action_name:
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(false)
		changing()
func _unhandled_key_input(event):
	rebind_action_key(event)
	button.button_pressed=false
	
func rebind_action_key(event):
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name,event)
	SaveSettings.save_keybinds(action_name,event)
	
	set_process_unhandled_key_input(false)
	changing()
	set_label()
