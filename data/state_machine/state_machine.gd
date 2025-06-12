extends Node
class_name StateMachine


@export var initial_state : int = 0
@export var body : Node

@onready var states : Array = get_children()

var current_state : int = 0


func _ready():
	current_state = initial_state


func _physics_process(delta):
	states[current_state].physics_update(delta)


func _process(delta):
	states[current_state].process_update(delta)
