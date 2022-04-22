extends Control

var cached_leaderboard_data = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	self.request_leaderboard_data()
	if cached_leaderboard_data.size() > 0: 
		self.update_leaderboard_data(cached_leaderboard_data)

func request_leaderboard_data():
	rpc_id(1, "remote_leaderboard_data_request")

# TODO: refactor
func update_leaderboard_data(dict):
	var leaderboard_scores_path = "NinePatchRect/LeaderboardScores"
	var battle_points = []
	var leaderboard_data = dict
	for value in dict.values(): battle_points.push_back(value["battle_points"])
	battle_points.sort()
	
	for i in range(10):
		var position = i + 1
		var label = get_node(leaderboard_scores_path + "/Label" + str(position))
		var battle_point = battle_points.pop_back()
		for key in leaderboard_data.keys():
			var player = leaderboard_data[key]
			if player["battle_points"] == battle_point:
				label.text = str(position) + ") "
				label.text += str(player["display_name"]) + "#" + str(player["id"]) + " - " + str(player["battle_points"])
				leaderboard_data.erase(key)
				break
		
	
remote func remote_leaderboard_data(remote_leaderboard_data):
	if self.cached_leaderboard_data.hash() != remote_leaderboard_data.hash():
		self.update_leaderboard_data(remote_leaderboard_data)

func _on_LobbyBtn_pressed():
	get_tree().change_scene("res://Scenes/Lobby/Lobby.tscn")
