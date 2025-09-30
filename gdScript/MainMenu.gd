extends Control
@onready var control: Control = $Control
@onready var control_2: Control = $Control2
@onready var control_3: Control = $Control3
@onready var main_control = $Control4
@onready var controls: Sprite2D = $Control2/GamehubArcade

func _ready() -> void:
	main_control.visible = Global.MainControl
	control.visible = Global.GameControl

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		toggle()

func toggle():
	visible = !visible
	get_tree().paused = visible

func show_and_hide(node1, node2):
	node1.show()
	node2.hide()

# PARENT
func _on_texture_button_4_pressed() -> void:
	get_tree().quit()

func _on_texture_button_pressed() -> void:
	show_and_hide(control, main_control)

func _on_texture_button_2_pressed() -> void:
	show_and_hide(control_2, main_control)

func _on_texture_button_3_pressed() -> void:
	show_and_hide(control_3, main_control)


# CHILD 
func _on_texture_button_2_pressed_child_1() -> void:
	show_and_hide(main_control, control)

func _on_texture_button_3_pressed_child_2() -> void:
	show_and_hide(main_control, control_2)

func _on_texture_button_2_pressed_child_3() -> void:
	show_and_hide(main_control, control_3)
