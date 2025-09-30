extends Node2D

@export var scroll_speed := 200
@onready var kecepatan: Timer = $"../Node/kecepatan"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	kecepatan.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	for child in get_children():
		child.position.x += scroll_speed * get_process_delta_time()
		if child.position.x >= child.texture.get_height():
			child.position.x -= child.texture.get_height() * 3
	pass

func _on_timer_timeout() -> void:
	scroll_speed += 25
	pass # Replace with function body.
