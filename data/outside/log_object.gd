extends Node3D


@onready var wood_objects = [$wood, $chopped_wood]


func display(mode : int):
	match mode:
		0:
			wood_objects[0].hide()
			wood_objects[1].hide()
		
		1:
			wood_objects[0].show()
			wood_objects[1].hide()
		
		2:
			wood_objects[0].hide()
			wood_objects[1].show()
