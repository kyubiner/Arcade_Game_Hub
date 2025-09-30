extends Node2D

@onready var timer: Timer = $Node/Timer
@onready var enemy_spawner = $enemy_spawner.get_children()
@onready var container_enemy: Node2D = $container_enemy
@onready var score_label: Label = $score
@onready var kecepatan: Timer = $Node/kecepatan
@onready var child_timer: Timer = $"Node/child-timer"
const CAR_ENEMY = preload("res://scene/race-car-2d/car-enemy.tscn")
var ENEMY : Array

var score:float = 0.0
var current_speed:float = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clear_enemy()
	timer.start()
	kecepatan.start()
	child_timer.start()
	update_score()

func spawn_enemy() -> void:
	var spawner_point = enemy_spawner.pick_random()
	var enemy = CAR_ENEMY.instantiate()
	enemy.SPEED = current_speed
	enemy.position = spawner_point.global_position
	container_enemy.add_child(enemy)
	ENEMY.append(enemy)
	pass

func clear_enemy() -> void:
	for e in ENEMY:
		if is_instance_valid(e):
			e.queue_free()
	ENEMY.clear()

func _on_timer_timeout() -> void:
	spawn_enemy()

func _process(delta: float) -> void:
	score += delta
	update_score()

func update_score() -> void:
	score_label.text = str(round(score))

func _on_kecepatan_timeout() -> void:
	current_speed += 50.0

func _on_childtimer_timeout() -> void:
	timer.wait_time -= 1
