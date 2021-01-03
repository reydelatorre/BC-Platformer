extends Node2D

onready var animationPlayer = $AnimationPlayer
onready var dialogueBox = $DialogueBox
var i = 0

func _ready():
	animationPlayer.play("clouds")


func talk(index: int) -> void:
	var dialogues = [
		["it was a cold, dark night..."],
		["mega-mark was burning the midnight oil."]
	]
	
	dialogueBox.talk(dialogues[index])
	


func _on_DialogueBox_dialogue_exit():
	# play intro_02 ;) 
	print("exit dialogue scene")


func _on_DialogueBox_gui_input(event):
	print('1')
