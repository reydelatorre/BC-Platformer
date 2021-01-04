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

var i = 0

func _ready():
	animationPlayer.play("clouds")
	markWorking.hide()
	darkness.hide()
	markPhone.hide()
	

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

func talk(index: int) -> void:
	var dialogues = [
		["it was a long, cold night..."],
		["mega-mark was burning the midnight oil."],
		["dotting his i's and crossing his t's, with laser focus."],
		["some say it would be his best work, yet! all his ducks were in a row."],
		["then suddenly, over at #prod-support..."],
		["@here @channel @mark Mark..."],
		["Magento and AWS is DOWN, GCP is DOWN. cloudflare is DOWN. Phoenix db is thrashing... and what's worse..."],
		["@Rey is ranting, and raving in #chaos-19 without proper use of Oxford commas..."],
		["no, no please don't, pleease--"],
		["can you take a look?"]
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
