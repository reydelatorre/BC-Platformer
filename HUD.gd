extends CanvasLayer

var insomnia_coins = 0
var postman_coins = 0

const INSOMNIA_COINS_MAX_WIN = 20
const POSTMAN_COINS_MAX_WIN = 10


func _ready():
	$InsomniaTextureRect/Label.text = String(insomnia_coins)
	$PostmanTextureRect/Label.text = String(postman_coins)

func _physics_process(delta):
	if insomnia_coins == INSOMNIA_COINS_MAX_WIN:
		get_tree().change_scene("res://Level01.tscn")

func _on_insomnia_coin_collected():
	insomnia_coins = insomnia_coins + 1
	_ready()


func _on_postman_coin_collected():
	postman_coins = postman_coins + 1
	_ready()
