extends Node

#preload obbstacles
const stump = preload("res://scene/dino-game/stump.tscn")
const barrel = preload("res://scene/dino-game/barrel.tscn")
const stone = preload("res://scene/dino-game/stone.tscn")
const bird = preload("res://scene/dino-game/bird.tscn")
var obstacle_type = [stump, barrel, stone]
var obstacles : Array = []
var bird_height = [200, 390]

# game variables
const DINO_START_POS := Vector2i(150, 568)
const CAM_START_POS := Vector2i(640, 360)
var difficulty
const MAX_DIFFICULTY : int = 2
var score : int
var speed : float
const SCORE_MODIFIER : int = 100
const START_SPEED : float = 10.0
const MAX_SPEED : int = 25
const SPEED_MODIFIER : int = 5000
var screen_size : Vector2i
var ground_height : int
var ground_height2 : int
var grounds: Array[Node] = []
var last_obs
var game_running : bool
@onready var ScoreText = $Camera2D/Score
@onready var ui_mobile = $ui_mobile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui_mobile.visible = !Global.UI
	screen_size = get_viewport().get_visible_rect().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	#ground_height2 = $Ground2.get_node("Sprite2D").texture.get_height()
	new_game()
	grounds = [$Ground, $Ground2, $Ground3]

func new_game():
	#reset variable
	score = 0
	difficulty = 0
	game_running = true
	for obs in obstacles:
		obs.queue_free()
	obstacles.clear()
	
	#reset the nodes
	$Dino.position = DINO_START_POS
	$Dino.velocity = Vector2i(0, 0)
	$Camera2D.position = CAM_START_POS
	$Ground.position = Vector2i(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_running:
		#speed up and adjust difficulty
		speed = START_SPEED + score / SPEED_MODIFIER
		if speed > MAX_SPEED:
			speed = MAX_SPEED
		adjust_difficulty()
	
	#move dino and camera
	$Dino.position.x += speed
	$Camera2D.position.x += speed
	
	#update score
	score += speed
	show_score()
	generate_obs()
	
	#update ground position
	for g in grounds:
		if $Camera2D.position.x - g.position.x > screen_size.x * 2.4:
			g.position.x += screen_size.x * grounds.size()
	for obs in obstacles:
			if obs.position.x < ($Camera2D.position.x - screen_size.x):
				remove_obs(obs)


func generate_obs() -> void:
	if obstacles.is_empty() or last_obs.position.x < score + randi_range(300, 500):
		var max_obs = difficulty + 1
		var obs
		for i in range(randi() % max_obs + 1):
			var obs_type = obstacle_type[randi() % obstacle_type.size()]
			obs = obs_type.instantiate()
			var obs_height = obs.get_node("Sprite2D").texture.get_height()
			var obs_scale = obs.get_node("Sprite2D").scale
			var obs_x : int = screen_size.x + score + 100 + (i * 100)
			var obs_y : int = screen_size.y - ground_height - (obs_height * obs_scale.y / 2) + 5
			last_obs = obs
			add_obs(obs, obs_x, obs_y)
		if difficulty == MAX_DIFFICULTY:
			if (randi() % 2) == 0:
				#generate bird obstacles
				obs = bird.instantiate()
				var obs_x : int = screen_size.x + score + 100
				var obs_y : int = bird_height[randi() % bird_height.size()]
				add_obs(obs, obs_x, obs_y)

func remove_obs(obs):
	obs.queue_free()
	obstacles.erase(obs)

func hit_obs(body):
	if body.name == "Dino":
		game_over()

func add_obs(obs, x, y) -> void:
	obs.position = Vector2i(x, y)
	obs.body_entered.connect(hit_obs)
	add_child(obs)
	obstacles.append(obs)

func show_score():
	ScoreText.text = str(score / SCORE_MODIFIER)

func adjust_difficulty():
	difficulty = score / SPEED_MODIFIER
	if difficulty > MAX_DIFFICULTY:
		difficulty = MAX_DIFFICULTY

func game_over():
	Global.score = score / SCORE_MODIFIER
	Global.path = "res://scene/dino-game/main.tscn"
	Global.background = "res://sprite/dino game/background dino run.png"
	get_tree().change_scene_to_file("res://scene/game-over.tscn")



