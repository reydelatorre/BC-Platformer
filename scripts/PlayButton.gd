extends Button


func _ready():
	pass


func _on_PlayButton_pressed():
	get_tree().change_scene("res://scenes/levels/Level01.tscn")
