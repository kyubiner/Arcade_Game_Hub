extends CharacterBody2D

var GRAVITY : int = 4200
const JUMP_SPEED : int = -1800
@onready var ui_mobile = $"../ui_mobile"
var jump : bool = false
var duck : bool = false


func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	if is_on_floor():
		$RunCol.disabled = false
		if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("ui_up") or jump:
			velocity.y = JUMP_SPEED
			$JumpSound.play()
		elif Input.is_action_pressed("ui_down") or duck:
			$AnimatedSprite2D.play("duck")
			$RunCol.disabled = true
		else:
			$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("jump")
	if Input.is_action_pressed("ui_down") or duck:
		GRAVITY += 1000
	else:
		GRAVITY = 4200
	move_and_slide()

func _on_key_up_button_down() -> void:
	jump = true

func _on_key_up_button_up() -> void:
	jump = false

func _on_key_down_button_down() -> void:
	duck = true

func _on_key_down_button_up() -> void:
	duck = false
