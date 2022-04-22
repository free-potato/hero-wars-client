extends Node

var battle_id = null
var player = {}
var enemy_player = {}
var rounds = {}
var battle_info = {}

func create_battle(battle_id, battle_info):
	self.battle_id = battle_id
	self.battle_info = battle_info
	self.rounds = battle_info["rounds"]
	if Player.id() == battle_info["player_1"]["id"]:
		self.player = battle_info["player_1"]
		self.enemy_player = battle_info["player_2"]
	else:
		self.player = battle_info["player_2"]
		self.enemy_player = battle_info["player_1"]
		
	get_tree().change_scene("res://Scenes/Arena/BattleArena.tscn")
		

func update_battle_info(battle_info):
	self.battle_info = battle_info
	self.rounds = battle_info["rounds"]
	if Player.id() == battle_info["player_1"]["id"]:
		self.player = battle_info["player_1"]
		self.enemy_player = battle_info["player_2"]
	else:
		self.player = battle_info["player_2"]
		self.enemy_player = battle_info["player_1"]

func enemy_player():
	return self.enemy_player
	
func player():
	return self.player
	
func current_round():
	return self.rounds.size() + 1
	
func prev_round():
	return self.rounds.size()
	
func rounds():
	return self.rounds

func victory_status():
	if battle_info["is_finished"] != true: return null
	if battle_info["winner"] == "draw": battle_info["winner"]
	return battle_info["winner"].to_int() == self.player_no()
	
func player_no():
	var player_no = 1 if Player.id() == self.battle_info["player_1"]["id"] else 2
	return player_no
	
func round_results(round_no):
	var round_info = self.rounds[round_no]
	var player_no = self.player_no()
	var enemy_no = 2 if player_no == 1 else 1
	var round_res = {
		"player": round_info["player_" + str(player_no)],
		"enemy": round_info["player_" + str(enemy_no)]
	}
	return round_res
	
func attack(method:String):
	var methods = ["head", "body", "legs", "d_head", "d_body", "d_legs"]
	if not methods.has(method): method = methods.front()
	var attack_details = {"battle_id": self.battle_id, "method": method}
	rpc_id(1, "remote_attack_details", attack_details)
	
remote func remote_update_battle_info(battle_info):
	self.update_battle_info(battle_info)
	get_tree().change_scene("res://Scenes/Arena/RoundResultsScreen.tscn")
	
