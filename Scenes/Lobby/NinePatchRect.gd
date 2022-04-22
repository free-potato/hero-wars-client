extends NinePatchRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func _on_LobbyBtn_pressed():
	get_tree().change_scene("res://Scenes/Lobby/Lobby.tscn")
