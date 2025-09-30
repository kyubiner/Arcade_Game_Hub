extends CharacterBody2D

@onready var score_kurma: Label = $"../score-kurma"
@onready var ui_mobile: CanvasLayer = $"../ui_mobile"

var point:int = 0
const SPEED = 500.0
var direction := 0
var right_pressed :bool = false
var left_pressed :bool = false
var bounce_coldown :float = 0.0

func _ready() -> void:
	ui_mobile.visible = !Global.UI

func _physics_process(delta: float) -> void:
	bounce_coldown -= delta
	var input := Input.get_axis("ui_left", "ui_right")
	if input != 0:
		direction = input
	elif !Global.UI and left_pressed or right_pressed == true:
		direction = int(right_pressed) - int(left_pressed)
	velocity.x = direction * SPEED
	move_and_slide()
	if is_on_wall() and bounce_coldown <= 0:
		direction *= -1
		bounce_coldown = 0.2

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == 'kurma':
		point += 1
		area.get_parent().queue_free()
		score_kurma.text = str(point)
	elif area.name == 'bomb':
		game_finished()

func game_finished() -> void:
	Global.score = point
	Global.path = "res://scene/catch-kurma/catch-kurma.tscn"
	Global.background = "res://sprite/catch kurma game/game-over_catch-kurma.png"
	get_tree().change_scene_to_file("res://scene/game-over.tscn")

func _on_key_left_button_down() -> void:
	left_pressed = true

func _on_key_right_button_down() -> void:
	right_pressed = true

func _on_key_left_button_up() -> void:
	left_pressed = false

func _on_key_right_button_up() -> void:
	right_pressed = false
