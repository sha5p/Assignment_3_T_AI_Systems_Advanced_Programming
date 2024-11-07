extends Node
var skeli=2
var current_dimension:String
enum Dimension { Dimension1, Dimension2 }
var current_dimensions = Dimension.Dimension1
func _ready():
	change()
func change_dimension(new_dimension):
	current_dimensions = new_dimension
	print(current_dimension,"This is current dm6")
	change()
func change()->void:
	match current_dimensions:
		Dimension.Dimension1:
			current_dimension="Dimension1"
		Dimension.Dimension2:
			current_dimension="Dimension2"
