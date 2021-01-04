extends Node2D

onready var animationPlayer = $AnimationPlayer
onready var dialogueBox = $DialogueBox
onready var markWorking = $MarkWorking
onready var background = $Background
onready var tileMap = $TileMap
onready var darkness = $Darkness
onready var what = $What
onready var slack = $Slack
onready var markPhone = $MarkPhone
onready var ohHiMark = $OhHiMark
onready var mark = $Mark
onready var teleport = $Teleport
onready var markHouse = $TileMap/MarkHouse

var i = 0

func _ready():
	animationPlayer.play("clouds")
	markHouse.play("bg")
	markWorking.hide()
	darkness.hide()
	markPhone.hide()
	mark.hide()
	

func scene2() -> void:
	background.hide()
	tileMap.hide()
	markWorking.show()
	
	
func scene3() -> void:
	markWorking.hide()
	darkness.show()
	

func scene4() -> void:
	darkness.hide()
	markPhone.show()
	

func final() -> void:
	markPhone.hide()
	background.show()
	tileMap.show()
	markHouse.play("empty")
	mark.show()
	mark.play("idle")

func talk(index: int) -> void:
	var dialogues = [
		["it was a long, cold night..."],
		["Mega Mark was burning the midnight oil."],
		["dotting his Is and crossing his Ts, with laser focus..."],
		["some say it would be his best work, yet! all his ducks were in a row."],
		["but then suddenly, over at #prod-support..."],
		["@here @channel @mark Mark..."],
		["AWS is DOWN. GCP is DOWN. cloudflare is DOWN. PWS pages are redirecting to onlyfans.com... and what's worse..."],
		["@Rey has gone full Robespierre on Oxford commas in #chaos-19..."],
		["@here @channel @mark can you take a look?"]
	]
	
	dialogueBox.talk(dialogues[index])
	
	
func close() -> void:
	dialogueBox.close()


func _on_DialogueBox_dialogue_exit():
	# play level 01 ;) 
	print("exit dialogue scene")


func what() -> void:
	what.play()


func slack() -> void:
	slack.play()


func ohHiMark() -> void:
	ohHiMark.play()


func fly() -> void:
	mark.play("fly")
	teleport.play()
	
	
func exit() -> void:
	get_tree().change_scene("res://scenes/levels/Level01.tscn")
