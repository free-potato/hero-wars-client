extends Control

onready var p_attack_method_label = get_node("NinePatchRect/ColorRect/VBoxContainer/PlayerAttackMethod")
onready var p_damage_dealt_label = get_node("NinePatchRect/ColorRect/VBoxContainer/PlayerDamageDealt")
onready var p_hp_reg_label = get_node("NinePatchRect/ColorRect/VBoxContainer/PlayerHpReg")

onready var e_attack_method_label = get_node("NinePatchRect/ColorRect/VBoxContainer/EnemyAttackMethod")
onready var e_damage_dealt_label = get_node("NinePatchRect/ColorRect/VBoxContainer/EnemyDamageDealt")
onready var e_hp_reg_label = get_node("NinePatchRect/ColorRect/VBoxContainer/EnemyHpReg")

onready var title = get_node("NinePatchRect/ColorRect/RoundResultLabel")
onready var next_round_btn_label = get_node("NinePatchRect/ColorRect2/NextRoundBtn/Label")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.show_results()

func show_results():
	var round_res = Battle.round_results(Battle.prev_round())
	var player_res = round_res["player"]
	var enemy_res = round_res["enemy"]
	p_attack_method_label.text = self.humanize_attack_method(player_res["attack_method"])
	e_attack_method_label.text = self.humanize_attack_method(enemy_res["attack_method"])
	
	p_damage_dealt_label.text = "Damage dealt: " + str(player_res["damage_dealt"])
	e_damage_dealt_label.text = "Damage dealt: " + str(enemy_res["damage_dealt"])
	
	p_hp_reg_label.text = "Hp Reg: " + str(player_res["hp_reg"])
	e_hp_reg_label.text = "Hp Reg: " + str(enemy_res["hp_reg"])
	
	if Battle.victory_status() != null:
		if str(Battle.victory_status()) == "draw":
			title.text = "Draw"
		elif Battle.victory_status() == true:
			title.text = "You Won"
		else:
			title.text = "You lost"
		next_round_btn_label.text = "Back to Lobby"

func humanize_attack_method(method):
	var word = ""
	if ["head", "body", "legs"].has(method):
		word = ("Hit " + method).capitalize()
	elif ["d_head", "d_body", "d_legs"].has(method):
		word = ("Dodged " + method.substr(1, -1)).capitalize()
		
	return word

func _on_NextRoundBtn_pressed():
	if Battle.victory_status() != null:
		get_tree().change_scene("res://Scenes/Lobby/Lobby.tscn")
	else:
		get_tree().change_scene("res://Scenes/Arena/BattleArena.tscn")
