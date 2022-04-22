extends Control

onready var username_input   = get_node("ColorRect/VBoxContainer/UsernameInput")
onready var password_input   = get_node("ColorRect/VBoxContainer/PasswordInput")
onready var password_input_2 = get_node("ColorRect/VBoxContainer/PasswordRepeatInput")
onready var create_acc_btn   = get_node("ColorRect/VBoxContainer/CreateAccountBtn")
onready var error_msg_label  = get_node("ColorRect/VBoxContainer/ErrorMsg")

func _on_LoginLink_pressed():
	get_tree().change_scene("res://Scenes/Auth/LoginScreen.tscn")


func _on_CreateAccountBtn_pressed():
	var username = username_input.text
	var password = password_input.text
	var password2 = password_input_2.text
		
	if username.length() < 3:
		show_error_msg("Username must containt at least 3 characters")
	elif password.length() < 6:
		show_error_msg("Password must contain at least 6 characters")
	elif password != password2:
		show_error_msg("Passwords don't match")
	else:
		create_acc_btn.disabled = true
		Gateway.connect_to_server(username, password, true)
		
func show_error_msg(msg):
	error_msg_label.text = msg


func _on_ExitGameBtn_pressed():
	get_tree().quit()
