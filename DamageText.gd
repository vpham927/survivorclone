extends Label

@export var text_speed := Vector2(0, -30)
@export var fade_out_timer := 1.0

var time_passed := 0.0  

func _process(delta: float) -> void:
	position += text_speed * delta
	time_passed += delta
	if time_passed >= fade_out_timer:
		queue_free()
