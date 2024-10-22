extends Control
@onready var option_button = $HBoxContainer/OptionButton

const Res_Dictionary : Dictionary={
	"1152 x 648" :Vector2i(1152,648),
	"1280 x 720" :Vector2i(1280,720),
	"1920 x 1080" :Vector2i(1920, 1080)
}

func _ready():
	option_button.item_selected.connect(on_resolution_selected)
	add_res_item()
func add_res_item():
	for res_size_text in Res_Dictionary:
		option_button.add_item(res_size_text)	

func on_resolution_selected(index: int):
	DisplayServer.window_set_size(Res_Dictionary.values()[index])
