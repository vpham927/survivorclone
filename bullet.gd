extends Area2D

var travelled_distance = 0.0
var damage = 10  # Base damage value

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

func _on_body_entered(body: Node2D) -> void:
	print("Bullet hit with damage: ", damage)
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(damage)
