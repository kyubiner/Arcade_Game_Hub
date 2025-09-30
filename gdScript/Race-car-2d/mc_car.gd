extends CharacterBody2D

const SPEED = 300.0
@onready var score: Label = $"../score"
var direction : float = 0.0
@onready var ui_mobile: CanvasLayer = $"../ui_mobile"

func _ready() -> void:
	ui_mobile.visible = !Global.UI

func _physics_process(delta: float) -> void:
	var keybord_dir := Input.get_axis("ui_up", "ui_down")
	var final_dir := direction if direction != 0 else keybord_dir
	if final_dir:
		velocity.y = final_dir * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	game_finished()

func game_finished() -> void:
	Global.score = score.text
	Global.path = "res://scene/race-car-2d/race-car-2d.tscn"
	Global.background = "res://sprite/race car 2d/game-over_car-race.png"
	get_tree().change_scene_to_file("res://scene/game-over.tscn")

func _on_key_up_button_down() -> void:
	direction = -1

func _on_key_up_button_up() -> void:
	direction = 0

func _on_key_down_button_down() -> void:
	direction = 1


func _on_key_down_button_up() -> void:
	pass # Replace with function body.
