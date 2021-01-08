extends CanvasLayer


var hitpoints = 10
var insomnia_coins = 0
var postman_coins = 0
var techlead_coins = 0

const INSOMNIA_COINS_MAX_WIN = 10
const POSTMAN_COINS_MAX_WIN = 15
const TECHLEAD_COINS_MAX_WIN = 2
const FULL_HITPOINTS = 10

onready var insomnia_label = $insomnia_label
onready var postman_label = $postman_label
onready var hitpoints_label = $hitpoints_label


func _ready():
	insomnia_label.text = "%s/%s" % [str(insomnia_coins), str(INSOMNIA_COINS_MAX_WIN)]
	postman_label.text = "%s/%s" % [str(postman_coins), str(POSTMAN_COINS_MAX_WIN)]
	hitpoints_label.text = "%s/%s" % [str(clamp(hitpoints, 0, 10)), str(FULL_HITPOINTS)]


func player_win():
	return postman_coins == POSTMAN_COINS_MAX_WIN and insomnia_coins == INSOMNIA_COINS_MAX_WIN


func player_loses():
	return hitpoints <= 0


func _physics_process(delta):
	if player_win():
		get_tree().change_scene("res://scenes/Winner.tscn")
		
	if postman_coins == 3:
		$AudioStreamPlayer2DSoMuchGarbage.play()

	
func _on_insomnia_coin_collected():
	insomnia_coins = insomnia_coins + 1
	_ready()


func _on_postman_coin_collected():
	postman_coins = postman_coins + 1
	_ready()


func _on_Player_mark_hurt(amount):
	hitpoints = hitpoints - amount
	_ready()


