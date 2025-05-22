extends CharacterBody2D

var health = 30
@onready var player = get_node("/root/Game/Player")

# function to play the walk animation
func _ready():
	%Slime.play_walk()

func _physics_process(delta):
	# give the global position of the mob to the player
	var direction = global_position.direction_to(player.global_position)
	# give the speed which should be lower than the player speed
	# maybe create a variable later to add modifiers to mob speed
	velocity = direction * 300.0
	move_and_slide()
 # function to take damage
func take_damage():
	health -= 10
	%Slime.play_hurt()

	if health <= 0:
		queue_free()
		const SMOKE_SCENCE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENCE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		player.gain_experience(10)
		print(player.experience)
		
		
# function to give the player experience
