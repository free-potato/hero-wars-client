extends Node

const SERVER_IP = "127.0.0.1"
const SERVER_PORT = 1910

var peer = NetworkedMultiplayerENet.new()
var username = null
var password = null
var is_new_account = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	if get_custom_multiplayer() == null:
		return
	if not custom_multiplayer.has_network_peer():
		return
	custom_multiplayer.poll()

func connect_to_server(username, password, is_new_account = false):
	var gateway_api = MultiplayerAPI.new()
	self.username = username
	self.password = password
	self.is_new_account = is_new_account
	
	peer.create_client(SERVER_IP, SERVER_PORT)
	set_custom_multiplayer(gateway_api)
	custom_multiplayer.set_root_node(self)
	custom_multiplayer.set_network_peer(peer)
	
	peer.connect("connection_succeeded", self, "_on_connection_succeeded")
	peer.connect("connection_failed", self, "_on_connection_failed")
	

func _on_connection_succeeded():
	print("Connected to the gateway")
	new_account_request() if self.is_new_account else request_login()
	
func _on_connection_failed():
	print("Connection to the gateway has failed")
	

func request_login():
	rpc_id(1, "remote_request_login", self.username, self.password)
	self.username = null
	self.password = null
	
func new_account_request():
	rpc_id(1, "remote_new_account_request", self.username, self.password)
	self.username = null
	self.password = null
	self.is_new_account = false
	
func disconnect_peer():
	peer.disconnect("connection_succeeded", self, "_on_connection_succeeded")
	peer.disconnect("connection_failed", self, "_on_connection_failed")
	peer.close_connection()

# Depreciated: use AuthController.auth_and_connect_to_game_server(token)
func connect_to_game_server(token):
	var lobby_screen_path = "res://Scenes/Lobby/Lobby.tscn"
	return AuthController.auth_and_connect_to_game_server(token, lobby_screen_path, null)

# TODO: combine remote_login_request_result with remote_new_account_request_result
remote func remote_login_request_result(result):
	if result["status"] == true:
		connect_to_game_server(result["token"])
	else:
		var login_screen_node = get_node("../LoginScreen")
		login_screen_node.show_error_msg(error_msg_humanize(result["message"]))
		login_screen_node.login_btn.disabled = false
		
	disconnect_peer()
	
remote func remote_new_account_request_result(result):
	if result["status"] == true:
		connect_to_game_server(result["token"])
	else:
		var new_acc_screen_node = get_node("../NewAccountScreen")
		new_acc_screen_node.show_error_msg(error_msg_humanize(result["message"]))
		new_acc_screen_node.create_acc_btn.disabled = false
		
	disconnect_peer()

# TODO refactor
func error_msg_humanize(error_msg):
	var msg = ""
	if error_msg == "username-taken":
		msg = "Username is taken"
	elif error_msg == "incorrect-details":
		msg = "Username or password is incorrect"
	elif error_msg == "username-too-short":
		msg = "Username is too short"
	elif error_msg == "password-too-short":
		msg = "Password is too short"
	else:
		msg = "Unknown error has occured. Please try again"
	return msg
