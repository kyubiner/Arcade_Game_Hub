extends CharacterBody2D

@onready var area_2d: Area2D = $Area2D
@onready var enemy_car: Sprite2D = $enemy_car
var textures = [
	preload("res://sprite/race car 2d/red car.png"),
	preload("res://sprite/race car 2d/blue car.png"),
	preload("res://sprite/race car 2d/real car.png")
]
var SPEED = 100.0

func _ready() -> void:
	enemy_car.texture = textures.pick_random()


func _process(delta: float) -> void:
	position.x += SPEED * delta
	move_and_slide()
	if position.x > get_viewport_rect().size.x + 100:
		queue_free()
