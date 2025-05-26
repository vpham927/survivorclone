extends Node2D

@export var stats: EnemyStats = EnemyStats.new()

#function to spawn mobs
func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	var new_mob2 = preload("res://mob2.tscn").instantiate()
	#Uses the PathFollow2D to spawn the mob at a random point on the path.
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	new_mob2.global_position = %PathFollow2D.global_position
	#Spawn the mob at the spawn rate
	#add_child(new_mob)
	add_child(new_mob2)
	

func _on_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	#pause the game
	get_tree().paused = true
