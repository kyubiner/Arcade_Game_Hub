extends Control

@onready var texture_button: TextureButton = $TextureButton
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_ui()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/creadit.tscn")
	pass # Replace with function body.

func change_ui() -> void:
	if Global.UI:
		ui_pc()
	elif !Global.UI:
		ui_mobile()
		pass

func ui_mobile() -> void:
	texture_button.texture_normal = preload("res://sprite/ui/ui_hp.png")
	texture_button.texture_pressed = preload("res://sprite/ui/ui_hp_pressed.png")

func ui_pc() -> void:
	texture_button.texture_normal = preload("res://sprite/ui/ui_pc.png")
	texture_button.texture_pressed = preload("res://sprite/ui/ui_pc_pressed.png")
	

func _on_texture_button_pressed() -> void:
	Global.UI = !Global.UI
	change_ui()
	pass # Replace with function body.
