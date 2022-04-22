extends Node

var info = {
	"attack": 0,
	"intelligence": 0,
	"defence": 0,
	"magic_defence": 0,
	"hp": 0,
	"mp": 0,
	"hp_reg": 0,
	"mp_reg": 0,
	"xp": 0,
	"updated_at": 0
}

func info():
	return self.info
	
func is_info_fetched():
	return self.info["updated_at"] > 0
	
func update_character_info():
	rpc_id(1, "remote_character_info")

remote func remote_character_info(remote_character_info):
	self.info = remote_character_info
	self.info["updated_at"] = OS.get_unix_time()
