extends Control

@onready var background: TextureRect = $background
@onready var score: Label = $score
var score_finished = Global.score
var scene_return = Global.path
var background_theme = Global.background

func _ready() -> void:
	score.text = str(score_finished)
	background.texture = load(background_theme)

func _on_texture_button_2_pressed() -> void:
	Global.score_protect_the_cilok = 0
	get_tree().change_scene_to_file(scene_return)

func _on_texture_button_pressed() -> void:
	Global.score_protect_the_cilok = 0
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")
	Global.MainControl = false
	Global.GameControl = true

func _on_take_screenhot_pressed() -> void:
	var img: Image = get_viewport().get_texture().get_image()
	var buffer = img.save_png_to_buffer()
	var b64 = Marshalls.raw_to_base64(buffer)

	JavaScriptBridge.eval("""
		var a = document.createElement('a');
		a.href = 'data:image/png;base64,""" + b64 + """';
		a.download = 'screenshot.png';
		a.click();
	""")
