extends CharacterBody2D


@export var stats: EnemyStats = EnemyStats.new()
@onready var player = get_node("/root/Game/Player")
var damage_text = preload("res://damage_text.tscn")

# function to play the walk animation
func _ready():
	pass#%Slime.play_walk()

func _physics_process(delta):
	# give the global position of the mob to the player
	var direction = global_position.direction_to(player.global_position)
	# give the speed which should be lower than the player speed
	# maybe create a variable later to add modifiers to mob speed
	velocity = direction * stats.speed
	move_and_slide()
 # function to take damage
func take_damage(damage_amount: int = 10):
	stats.health -= damage_amount
	#%Slime.play_hurt()
	var damage_text_instance = damage_text.instantiate()
	#set the damage text to the damage amount from bullet script
	damage_text_instance.text = str(damage_amount)
	damage_text_instance.global_position = global_position
	get_parent().add_child(damage_text_instance)

	if stats.health <= 0:
		queue_free()
		const SMOKE_SCENCE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENCE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		player.gain_experience(stats.experience_reward)
		print("Experience Reward: ", stats.experience_reward)
		print(player.experience)
		
		
# function to give the player experience
