extends HBoxContainer

@onready var texture_button: TextureButton = $VBoxContainer/VBoxContainer/TextureButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	focus_menu()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func focus_menu() -> void:
	$VBoxContainer/VBoxContainer/TextureButton.grab_focus()
	pass

func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/race-car-2d/race-car-2d.tscn")
	pass # Replace with function body.


func _on_texture_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/catch-kurma/catch-kurma.tscn")
	pass # Replace with function body.


func _on_texture_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/protect-the-cilok/protect-the-cilok.tscn")
	pass # Replace with function body.
	


func _on_texture_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/dino-game/main.tscn")
	pass # Replace with function body.
