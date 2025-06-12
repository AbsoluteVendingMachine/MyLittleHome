extends State


@onready var minigame = $Minigame2
@onready var cursor = $Minigame2/Cursor

var fish = preload("res://data/water/fish/fish.tscn")


func physics_update(_delta : float) -> void:
	state_machine.body.camera.position = state_machine.body.camera_positions[1]
	state_machine.body.fishing_rod.show()
	state_machine.body.animation_player.play("Fishing")
	if not cursor.active:
		cursor.active = true
		minigame.show()
		for count in range(state_machine.body.limits[1]):
			var fish_instance = fish.instantiate()
			minigame.add_child(fish_instance)
		
	if state_machine.body.fish >= state_machine.body.limits[1]:
		state_machine.body.camera.position = state_machine.body.camera_positions[0]
		cursor.active = false
		minigame.hide()
		state_machine.body.fishing_rod.hide()
		state_machine.current_state = 0
		state_machine.body.forced_state = "none"
		state_machine.body.inside_group = "none"
	
	if cursor.position.x > 288:
		cursor.position.x = 288
	
	if cursor.position.x < 32:
		cursor.position.x = 32
		
	if cursor.position.y > 416:
		cursor.position.y = 416
	
	if cursor.position.y < 160:
		cursor.position.y = 160
