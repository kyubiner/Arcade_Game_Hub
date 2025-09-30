extends Control

@onready var bgm_label: Label = $"VBoxContainer/TextureButton2/bgm-section/Label"
@onready var bgm_icon: TextureRect = $"VBoxContainer/TextureButton2/bgm-section/TextureRect"
@onready var sfx_label: Label = $"VBoxContainer/TextureButton4/sfx-section/Label"
@onready var sfx_icon: TextureRect = $"VBoxContainer/TextureButton4/sfx-section/TextureRect2"
@onready var controls_label: Label = $VBoxContainer/TextureButton/Label

var bgm_level := 100
var sfx_level := 100

var tex_bgm := {
	0: preload("res://sprite/ui/range-button-1.png"),
	50: preload("res://sprite/ui/range-button-2.png"),
	100: preload("res://sprite/ui/range-button-3.png")
}

var tex_sfx := {
	0: preload("res://sprite/ui/range-button-1.png"),
	50: preload("res://sprite/ui/range-button-2.png"),
	100: preload("res://sprite/ui/range-button-3.png")
}

func _ready() -> void:
	focus_mode = Control.FOCUS_ALL
	update_ui()

func update_ui() -> void:
	bgm_icon.texture = tex_bgm[bgm_level]
	sfx_icon.texture = tex_sfx[sfx_level]

func toggle_bgm() -> void:
	if bgm_level == 100:
		bgm_level = 50
	elif bgm_level == 50:
		bgm_level = 0
	else:
		bgm_level = 100
	
	var bus = AudioServer.get_bus_index("bgm")
	AudioServer.set_bus_volume_db(bus, linear_to_db(bgm_level / 100.0))
	update_ui()

func toggle_sfx() -> void:
	if sfx_level == 100:
		sfx_level = 50
	elif sfx_level == 50:
		sfx_level = 0
	else:
		sfx_level = 100
	
	var bus = AudioServer.get_bus_index("sfx")
	AudioServer.set_bus_volume_db(bus, linear_to_db(sfx_level / 100.0))
	update_ui()

func _on_texture_button_2_pressed() -> void:
	toggle_bgm()

func _on_texture_button_4_pressed() -> void:
	toggle_sfx()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		toggle()

func toggle():
	visible = !visible
	get_tree().paused = visible

func show_and_hide(node1, node2):
	node1.show()
	node2.hide()

func _on_texture_button_pressed() -> void:
	show_and_hide($GamehubArcade, $VBoxContainer)

func _on_texture_button_pressed_child() -> void:
	show_and_hide($VBoxContainer, $GamehubArcade)
