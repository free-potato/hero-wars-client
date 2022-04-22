extends Node

const SERVER_IP = "127.0.0.1"
const SERVER_PORT = 1909

var peer = null #NetworkedMultiplayerENet.new()
var token = null

# Called when the node enters the scene tree for the first time.
func _ready():
	peer = NetworkedMultiplayerENet.new()
	#connect_to_server()

func connect_to_server():
	peer.create_client(SERVER_IP, SERVER_PORT)
	get_tree().network_peer = peer
	
	peer.connect("connection_succeeded", self, "_on_connection_succeeded")
	peer.connect("connection_failed", self, "_on_connection_failed")
	

func _on_connection_succeeded():
	print("Connected to the server")
	self.authenticate_player(self.token)
	
func _on_connection_failed():
	print("Connection failed")
	AuthController.set_auth_status(false)
	
func authenticate_player(token):
	rpc_id(1, "remote_authenticate_player", token)
	
remote func remote_authentication_result(result):
	AuthController.set_auth_status(result)
	if result != true:
		disconnect_peer()
		
func disconnect_peer():
	peer.disconnect("connection_succeeded", self, "_on_connection_succeeded")
	peer.disconnect("connection_failed", self, "_on_connection_failed")
	peer.close_connection()
