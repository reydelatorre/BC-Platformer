extends CanvasLayer


var hitpoints = 10
var insomnia_coins = 0
var postman_coins = 0
var techlead_coins = 0

const INSOMNIA_COINS_MAX_WIN = 10
const POSTMAN_COINS_MAX_WIN = 15
const TECHLEAD_COINS_MAX_WIN = 2
const FULL_HITPOINTS = 10


func _ready():
	$insomnia_label.text = String(insomnia_coins) + "/" + String(INSOMNIA_COINS_MAX_WIN)
	$postman_label.text = String(postman_coins) + "/" + String(POSTMAN_COINS_MAX_WIN)
	$hitpoints_label.text = String(hitpoints) + "/" + String(FULL_HITPOINTS)


func player_win():
	return postman_coins == POSTMAN_COINS_MAX_WIN and insomnia_coins == INSOMNIA_COINS_MAX_WIN

func player_loses():
	return hitpoints <= 0


func _physics_process(delta):
	if player_win():
		get_tree().change_scene("res://scenes/Winner.tscn")
	pass

	
func _on_insomnia_coin_collected():
	insomnia_coins = insomnia_coins + 1
	_ready()


func _on_postman_coin_collected():
	postman_coins = postman_coins + 1
	_ready()


func _on_Player_mark_hurt():
	hitpoints = hitpoints - 1
	_ready()


