extends Area2D

var damage_text = preload("res://damage_text.tscn")

var travelled_distance = 0.0
var damage = 10  # Base damage value
var crit_chance = 0.20  # 20% chance to crit
var crit_multiplier = 2.0  # Critical hits do double damage

func set_damage_from_level(level: int) -> void:
	damage = 10 + (level - 1) * 5  # Increase damage by 5 per level
	
	# Commented out because it was spamming the console
	# print("Bullet created with damage: ", damage)

func _physics_process(delta: float) -> void:
	const SPEED = 500
	const RANGE = 1200
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	 #destroy bullet after travelled distance
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()

func calculate_damage() -> int:
	# Roll for critical hit
	var is_critical = randf() <= crit_chance
	var final_damage = damage
	
	if is_critical:
		final_damage = int(damage * crit_multiplier)
		print("CRITICAL HIT! Damage: ", final_damage)
	
	return final_damage

func _on_body_entered(body: Node2D) -> void:
	var final_damage = calculate_damage()
	print("Bullet hit with damage: ", final_damage)
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(final_damage)
