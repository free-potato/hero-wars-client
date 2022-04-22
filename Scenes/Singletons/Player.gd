extends Node

var player_info = {
	"display_name": null,
	"id": null,
	"wins": 0,
	"losses": 0,
	"battle_points" : 0,
	"updated_at": 0
}

func update_display_name(new_name):
	rpc_id(1, "remote_update_display_name", new_name)

func is_player_info_fetched():
	return self.player_info["updated_at"] > 0

func player_info():
	return self.player_info
	
func id():
	return self.player_info["id"]

func update_player_info():
	rpc_id(1, "remote_player_info")

remote func remote_player_info(remote_player_info):
	self.player_info = remote_player_info
	self.player_info["updated_at"] = OS.get_unix_time()
	
	if remote_player_info["display_name"] == null:
		get_tree().change_scene("res://Scenes/Lobby/UserInfoEditScreen.tscn")
