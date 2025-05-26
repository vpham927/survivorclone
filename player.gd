extends CharacterBody2D 

signal health_depleted
signal level_increased(new_level)

var health = 100.0
var experience = 0
var level = 1
var experience_to_next_level = 100  # Base XP needed for first level up

func get_level() -> int:
	return level

func calculate_experience_requirement(level_num: int) -> int:
	return level_num * 100  # Each level requires 100 more XP than the previous

func gain_experience(amount: int) -> void:
	experience += amount
	%ExpBar.max_value = experience_to_next_level
	%ExpBar.value = experience
	while experience >= experience_to_next_level:
		level_up() 

func level_up() -> void:
	level += 1
	experience -= experience_to_next_level
	experience_to_next_level = calculate_experience_requirement(level)
	level_increased.emit(level)
	print("You are now level: ", level)
	%LevelLabel.text = "Level: " + str(level)
	print("Health: ", health)
	restore_health()

func restore_health() -> void:
	health = 100.0
	%HealthBar.value = health

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 600 #pixels
	move_and_slide() #pre made function in godot
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()

	const DAMAGE_RATE = 50
	var overlappping_mobs = %HurtBox.get_overlapping_bodies()
	if overlappping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlappping_mobs.size() * delta
		%HealthBar.value = health
		if health <= 0.0:
			health_depleted.emit()
