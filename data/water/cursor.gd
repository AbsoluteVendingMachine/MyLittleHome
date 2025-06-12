extends Sprite2D


var active : bool


func _physics_process(delta):
	if active:
		position.x += (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * delta * 80
		
		position.y += (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")) * delta * 80
