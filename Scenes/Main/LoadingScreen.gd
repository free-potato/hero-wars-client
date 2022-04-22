extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var login_screen_path = "res://Scenes/Auth/LoginScreen.tscn"
	var lobby_screen_path = "res://Scenes/Lobby/Lobby.tscn"
	if AuthController.token_present():
		var token = AuthController.load_token()
		AuthController.auth_and_connect_to_game_server(token, lobby_screen_path, login_screen_path)
	else:
		yield(get_tree().create_timer(1.0), "timeout")
		get_tree().change_scene(login_screen_path)

