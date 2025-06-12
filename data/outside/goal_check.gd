extends Timer

signal timer_update(count : int)

@onready var player = get_tree().get_first_node_in_group("player_body")
@onready var main = get_tree().get_first_node_in_group("main")
@onready var exit = $Area3D
 
var count : int = 0


func end_day():
	main.time_left_today = abs(90 - count)
	main.current_tasks_done = [player.logs, player.fish, player.boxes]
	exit.monitorable = true
	stop()


func _on_timeout():
	count += 1
	emit_signal("timer_update", abs(90 - count))
	if player.boxes == player.limits[2] and player.fish == player.limits[1] and player.logs == player.limits[0]:
		end_day()
	
	if count >= 90:
		player.day_over = true
		main.current_day_over = true
		end_day()
