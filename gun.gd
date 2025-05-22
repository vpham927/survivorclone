extends Area2D

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0: 
		var target_enemy = enemies_in_range[0]
		look_at(target_enemy.global_position)

func shoot():
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	#loads the new bullet in the shooting point position.
	new_bullet.global_position = %ShootingPoint.global_position
	#gives the bullet the same rotation as the shooting point.
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	
	# Get the player's level and set bullet damage
	var player = get_parent()
	if player and player.has_method("get_level"):
		new_bullet.set_damage_from_level(player.level)

	%ShootingPoint.add_child(new_bullet)
	

func _on_timer_timeout() -> void:
	shoot()
