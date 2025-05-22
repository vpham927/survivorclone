extends Node2D

	
#function to spawn mobs
func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	#Uses the PathFollow2D to spawn the mob at a random point on the path.
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)


func _on_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	#pause the game
	get_tree().paused = true
