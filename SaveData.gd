extends Node
#makes const so file cant be broken somehow
const SAVE_FILE = "user://save_file.save"
var g_data = {
}
func _ready():
	load_data()
func load_data():
	if not FileAccess.file_exists(SAVE_FILE):
		save_data()  # Save the initial g_data to the file
	else:
		# If the file exists, load the data
		var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
		file.open(SAVE_FILE, FileAccess.READ)
		g_data = file.get_var()
		print("This is the current game data",g_data)
		file.close()

func save_data():
	#writes to file based on varibles
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	file.store_var(g_data)
	file.close()
