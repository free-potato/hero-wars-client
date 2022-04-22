extends Control

onready var display_name_node  = get_node("NinePatchRect/UserInfoContainer/StatsPointsContainer/DisplayName")
onready var user_id_node       = get_node("NinePatchRect/UserInfoContainer/StatsPointsContainer/ID")
onready var battle_wins_node   = get_node("NinePatchRect/UserInfoContainer/StatsPointsContainer/WinsPoints")
onready var battle_losses_node = get_node("NinePatchRect/UserInfoContainer/StatsPointsContainer/LossesPoints")
onready var battle_points_node = get_node("NinePatchRect/UserInfoContainer/StatsPointsContainer/BattlePoints")

onready var attack_node       = get_node("NinePatchRect/CharacterStatsContainer/StatsPointsContainer/Attack")
onready var intelligence_node = get_node("NinePatchRect/CharacterStatsContainer/StatsPointsContainer/Intelligence")
onready var defence_node      = get_node("NinePatchRect/CharacterStatsContainer/StatsPointsContainer/Defence")
onready var m_defence_node    = get_node("NinePatchRect/CharacterStatsContainer/StatsPointsContainer/MagicDefence")
onready var hp_node           = get_node("NinePatchRect/CharacterStatsContainer/StatsPointsContainer/HP")
onready var mp_node           = get_node("NinePatchRect/CharacterStatsContainer/StatsPointsContainer/MP")
onready var hp_reg_node       = get_node("NinePatchRect/CharacterStatsContainer/StatsPointsContainer/HpReg")
onready var mp_reg_node       = get_node("NinePatchRect/CharacterStatsContainer/StatsPointsContainer/MpReg")
onready var xp_node           = get_node("NinePatchRect/CharacterStatsContainer/StatsPointsContainer/XP")


# Called when the node enters the scene tree for the first time.
func _ready():
	Player.update_player_info()
	Character.update_character_info()
	if Player.is_player_info_fetched():
		self.update_user_info_container()
		self.update_character_stats_container()

func update_user_info_container():
	var user_info = Player.player_info()
	display_name_node.text  = str(user_info["display_name"])
	user_id_node.text       = str(user_info["id"])
	battle_wins_node.text   = str(user_info["wins"])
	battle_losses_node.text = str(user_info["losses"])
	battle_points_node.text = str(user_info["battle_points"])
	

func update_character_stats_container():
	var character_stats = Character.info()
	attack_node.text       = str(character_stats["attack"])
	intelligence_node.text = str(character_stats["intelligence"])
	defence_node.text      = str(character_stats["defence"])
	m_defence_node.text    = str(character_stats["magic_defence"])
	hp_node.text           = str(character_stats["hp"])
	mp_node.text           = str(character_stats["mp"])
	hp_reg_node.text       = str(character_stats["hp_reg"])
	mp_reg_node.text       = str(character_stats["mp_reg"])
	xp_node.text           = str(character_stats["xp"])
	


func _on_ExitGameBtn_pressed():
	get_tree().quit()


func _on_UpdateUserInfoTimer_timeout():
	self.update_user_info_container()
	self.update_character_stats_container()

func _on_LogoutBtn_pressed():
	AuthController.log_out()
	#get_tree().change_scene("res://Scenes/Auth/LoginScreen.tscn")
	get_tree().quit()


func _on_ArenaBtn_pressed():
	get_tree().change_scene("res://Scenes/Arena/Arena.tscn")


func _on_TutorialBtn_pressed():
	get_tree().change_scene("res://Scenes/Lobby/TutorialScreen.tscn")


func _on_LeaderboardBtn_pressed():
	get_tree().change_scene("res://Scenes/Lobby/Leaderboard.tscn")
