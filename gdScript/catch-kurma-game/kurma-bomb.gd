extends CharacterBody2D

var gravity:float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity.y += gravity
	if position.y > get_viewport_rect().size.y + 100:
		queue_free()
	move_and_slide()
	pass

func _on_difficult_timer_timeout() -> void:
	gravity += 1.0
	gravity = min(gravity, 10.0)
	pass # Replace with function body.
