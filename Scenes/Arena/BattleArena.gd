extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	self.update_round_label()
	self.fill_players_stats()

func update_round_label():
	get_node("NinePatchRect/RoundLabel").text = "Round " + str(Battle.current_round())

# TODO: refactor
func fill_players_stats():
	var stats_container_name = "PlayerStatsContainer"
	var player_stats = Battle.player()
	var enemy_stats = Battle.enemy_player()
	for stats in [player_stats, enemy_stats]:
		for key in stats.keys():
			var path = "NinePatchRect/"+stats_container_name+"/PointsContainer/" + str(key)
			get_node(path).text = str(stats[key])
			
		stats_container_name = "EnemyStatsContainer"


func _on_HeadAttackBtn_pressed():
	Battle.attack("head")
	get_tree().change_scene("res://Scenes/Arena/WaitingScreen.tscn")

func _on_BodyAttackBtn_pressed():
	Battle.attack("body")
	get_tree().change_scene("res://Scenes/Arena/WaitingScreen.tscn")

func _on_LegAttackBtn_pressed():
	Battle.attack("legs")
	get_tree().change_scene("res://Scenes/Arena/WaitingScreen.tscn")

func _on_HeadDodgeBtn_pressed():
	Battle.attack("d_head")
	get_tree().change_scene("res://Scenes/Arena/WaitingScreen.tscn")

func _on_BodyDodgeBtn_pressed():
	Battle.attack("d_body")
	get_tree().change_scene("res://Scenes/Arena/WaitingScreen.tscn")

func _on_LegDodgeBtn_pressed():
	Battle.attack("d_legs")
	get_tree().change_scene("res://Scenes/Arena/WaitingScreen.tscn")
