extends Node2D

@onready var timer_spawn: Timer = $"../Timer-spawn"
@onready var cilok: StaticBody2D = $"../cilok"
@onready var score: Label = $"../score"

var lalat_container = {
	'lalat_biasa': preload("res://scene/protect-the-cilok/lalat-biasa.tscn"),
	'lalat_cepat': preload("res://scene/protect-the-cilok/lalat-cepat.tscn"),
	'lalat_kuat':  preload("res://scene/protect-the-cilok/lalat-kuat.tscn")
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer_spawn.start()
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score.text = str(Global.score_protect_the_cilok)

func _on_timerspawn_timeout() -> void:
	var amount = 1
	if Global.score_protect_the_cilok >= 100:
		amount = 3
	elif Global.score_protect_the_cilok >= 50:
		amount = 2
	else:
		amount = 1
	for i in amount:
		spawn_lalat(choose_lalat())

func spawn_lalat(lalat: String) -> void:
	var lalat_spawn = lalat_container[lalat].instantiate()
	var screen_size = get_viewport_rect().size
	var margin = 100
	var side = randi() % 4
	var spawn_pos = Vector2()
	
	match side:
		0:
			spawn_pos = Vector2(randf() * screen_size.x, -margin)
		1:
			spawn_pos = Vector2(randf() * screen_size.x, screen_size.y + margin)
		2:
			spawn_pos = Vector2(-margin, randf() * screen_size.y)
		3:
			spawn_pos = Vector2(screen_size.x + margin, randf() * screen_size.y)
	lalat_spawn.target = cilok
	lalat_spawn.global_position = spawn_pos
	add_child(lalat_spawn)

func choose_lalat() -> String:
	var score = Global.score_protect_the_cilok
	var choose = []
	
	if score >= 50:
		choose = ['lalat_biasa', 'lalat_cepat', 'lalat_kuat', 'lalat_kuat']
	elif score >= 20:
		choose = ['lalat_biasa', 'lalat_biasa', 'lalat_cepat']
	else:
		choose = ['lalat_biasa']
	return choose[randi() % choose.size()]


func _on_area_2d_area_entered(area: Area2D) -> void:
	Global.score = Global.score_protect_the_cilok
	Global.path = "res://scene/protect-the-cilok/protect-the-cilok.tscn"
	Global.background = "res://sprite/protect the cilok/game_over_protect_the_cilok.png"
	get_tree().change_scene_to_file("res://scene/game-over.tscn")
	pass # Replace with function body.
