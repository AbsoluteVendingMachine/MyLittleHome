extends CanvasLayer


@export var out_toggle : bool
@export var waiting_for_activation : bool

@onready var animation_player = $AnimationPlayer


func activate(out_toggle_input : bool, queue_free_time : float):
	if out_toggle_input:
		animation_player.play("Out")
		
	else:
		animation_player.play("In")
	
	await get_tree().create_timer(queue_free_time).timeout
	queue_free()


func _ready():
	if not waiting_for_activation:
		activate(out_toggle, 1.0)
