extends Control

onready var search_battle_btn = get_node("NinePatchRect/ColorRect2/SearchBattleBtn")
onready var lobby_btn = get_node("NinePatchRect/ColorRect/LobbyBtn")
onready var players_searching_label = get_node("NinePatchRect/NinePatchRect2/PlayersSearchingLabel")

var is_searching = false

func _ready():
	self.update_searching_players_list()

func _on_LobbyBtn_pressed():
	lobby_btn.disabled = true
	if is_searching: self.cancel_search_battle()
	get_tree().change_scene("res://Scenes/Lobby/Lobby.tscn")

func _on_SearchBattleBtn_pressed():
	if is_searching: self.cancel_search_battle()
	else: self.search_battle()
	
func update_searching_players_list():
	rpc_id(1, "remote_searching_players")
	
func search_battle():
	is_searching = true
	search_battle_btn.disabled = true
	search_battle_btn.get_node("Label").text = "Searching..."
	rpc_id(1, "remote_search_battle")
	yield(get_tree().create_timer(1.0), "timeout")
	search_battle_btn.disabled = false

func cancel_search_battle():
	search_battle_btn.disabled = true
	search_battle_btn.get_node("Label").text = "Canceling..."
	rpc_id(1, "remote_cancel_search_battle")
	
remote func remote_cancel_search_battle():
	is_searching = false
	search_battle_btn.disabled = false
	search_battle_btn.get_node("Label").text = "Search"
	
remote func remote_searching_players(remote_searching_players):
	players_searching_label.text = "Players searching: " + str(remote_searching_players.size())
	
func _on_PlayersSearchingListUpdateTimer_timeout():
	self.update_searching_players_list()
	
remote func remote_start_battle(battle_id, battle_details):
	Battle.create_battle(battle_id, battle_details)
