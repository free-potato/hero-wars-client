extends Node

var auth_details = {
	"is_authenticated": false,
	"update_at": 0
}

func _ready():
	#self.load_token()
	pass
	
func is_authenticated():
	return auth_details["is_authenticated"] == true
	
func set_auth_status(is_authenticated):
	self.auth_details["is_authenticated"] = is_authenticated
	self.auth_details["update_at"] = OS.get_unix_time()

# s_redirect_path redirects to given scene if auth successful
# f_redirect_path redirects to given scene if auth unsuccessful
# if null, does not redirects
func auth_and_connect_to_game_server(token, s_redirect_path = null, f_redirect_path = null):
	Server.token = token
	Server.connect_to_server()
	var request_time = OS.get_unix_time()
	
	while (OS.get_unix_time() - request_time) < 6:
		if auth_details["update_at"] >= request_time: break
		yield(get_tree().create_timer(2), "timeout")
	
	if self.is_authenticated():
		self.save_token(token)
		if s_redirect_path != null: get_tree().change_scene(s_redirect_path)
	else:
		self.log_out()
		if f_redirect_path != null: get_tree().change_scene(f_redirect_path)
	
	return self.is_authenticated()

func token_present():
	return load_token().length() > 0

func save_token(token):
	return # comment out when testing
	var file = File.new()
	file.open("user://token.dat", File.WRITE)
	file.store_string(token)
	file.close()
	
func log_out():
	self.save_token("")

func load_token():
	var file = File.new()
	file.open("user://token.dat", File.READ)
	var token = file.get_as_text()
	file.close()
	return token
