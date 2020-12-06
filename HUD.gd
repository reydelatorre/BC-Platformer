extends CanvasLayer

var insomnia_coins = 0
var postman_coins = 0
var techlead_coins = 0
var troll_coins = 0

const INSOMNIA_COINS_MAX_WIN = 8
const POSTMAN_COINS_MAX_WIN = 10
const TECHLEAD_COINS_MAX_WIN = 2
const TROLL_COINS_MAX_WIN = 1


func _ready():
	$insomnia_label.text = String(insomnia_coins)
	$postman_label.text = String(postman_coins)
	$troll_label.text = String(troll_coins)

func _physics_process(delta):
	if insomnia_coins == INSOMNIA_COINS_MAX_WIN:
		get_tree().change_scene("res://Level01.tscn")

func _on_insomnia_coin_collected():
	insomnia_coins = insomnia_coins + 1
	_ready()


func _on_postman_coin_collected():
	postman_coins = postman_coins + 1
	_ready()


func _on_troll_coin_collected():
	troll_coins = troll_coins + 1
	_ready()
