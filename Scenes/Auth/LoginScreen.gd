extends Control

onready var username_input  = get_node("ColorRect/VBoxContainer/UsernameInput")
onready var password_input  = get_node("ColorRect/VBoxContainer/PasswordInput")
onready var login_btn       = get_node("ColorRect/VBoxContainer/LoginBtn")
onready var error_msg_label = get_node("ColorRect/VBoxContainer/ErrorMsg")

func _on_LoginBtn_pressed():
	if username_input.text.length() < 1 or password_input.text.length() < 1:
		show_error_msg("Username and password can't be empty")
	else:
		login_btn.disabled = true
		var username = username_input.text
		var password = password_input.text
		Gateway.connect_to_server(username, password)


func _on_CreateAccountLink_pressed():
	get_tree().change_scene("res://Scenes/Auth/NewAccountScreen.tscn")
	
func show_error_msg(msg):
	error_msg_label.text = msg


func _on_ExitGameBtn_pressed():
	get_tree().quit()
