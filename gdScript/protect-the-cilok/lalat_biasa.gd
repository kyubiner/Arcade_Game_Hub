extends CharacterBody2D

const SPEED: float = 50.0
var health: int = 1
@onready var target: Node2D

func _physics_process(delta: float) -> void:
	if target:
		var direction = (target.position - global_position).normalized()
		velocity = direction * SPEED
		move_and_slide()
		look_at(target.position)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton and event.pressed) or (event is InputEventScreenTouch and event.pressed):
		$ClickSound.play()
		health -= 1
		if health <= 0:
			$AnimatedSprite2D/Area2D.set_deferred("monitoring", false)
			$AnimatedSprite2D/Area2D.set_deferred("input_pickable", false)
			await $ClickSound.finished
			Global.score_protect_the_cilok += 1
			call_deferred("queue_free")
