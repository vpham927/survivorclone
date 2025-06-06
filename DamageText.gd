extends Label
#This script is used to display damage text on the screen

@export var text_speed := Vector2(0, -30) #The speed of the text
@export var fade_out_timer := 1.0 #The time it takes for the text to fade out

var time_passed := 0.0  

func _process(delta: float) -> void:
	position += text_speed * delta
	time_passed += delta
	if time_passed >= fade_out_timer:
		queue_free()

func crit_text() -> void:
	modulate = Color(1, 0, 0, 1)

func normal_text() -> void:
	modulate = Color(1, 1, 1, 1)
