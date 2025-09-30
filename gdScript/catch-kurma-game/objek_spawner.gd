extends Node2D

@onready var difficult_timer: Timer = $"../difficult_timer"
@onready var spawn_timer: Timer = $"../spawn_timer"
@onready var container_kurma: Node2D = $"../container_kurma"
@onready var container_bom: Node2D = $"../container_bom"
var scene = {
	'kurma': preload("res://scene/catch-kurma/kurma.tscn"),
	'bomb': preload("res://scene/catch-kurma/bom.tscn")
}
const X_MIN = 150
const X_MAX = 1370
const Y_SPAWN = -270
var container = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.start()
	difficult_timer.start()
	container = {
		'kurma':container_kurma,
		'bomb':container_bom
	}
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_spawn_timer_timeout() -> void:
	randomize()
	var change = randi() % 100
	if change <= 25:
		spawn_item('bomb')
	else:
		spawn_item('kurma')
	pass # Replace with function body.

func spawn_item(item):
	if scene.has(item) and container.has(item):
		var instantiate = scene[item].instantiate()
		var random_x = randi_range(X_MIN, X_MAX)
		instantiate.position = Vector2(random_x, Y_SPAWN)
		container[item].add_child(instantiate)
	pass

func _on_difficult_timer_timeout() -> void:
	spawn_timer.wait_time -= 0.2
	spawn_timer.wait_time = max(spawn_timer.wait_time, 0.5)
	pass # Replace with function body.
