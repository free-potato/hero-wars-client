extends Control

onready var set_btn = get_node("NinePatchRect/ColorRect/ColorRect/SetDisplayNameBtn")
onready var display_name_input = get_node("NinePatchRect/ColorRect/DisplayNameInput")

func _on_SetDisplayNameBtn_pressed():
	if display_name_input.text.length() < 1:
		pass
	elif display_name_input.text.length() > 32:
		pass
	else:
		set_btn.disabled = true
		Player.update_display_name(display_name_input.text)
		get_tree().change_scene("res://Scenes/Lobby/Lobby.tscn")
