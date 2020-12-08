extends CanvasLayer

var insomnia_coins = 0
var postman_coins = 0
var techlead_coins = 0

const INSOMNIA_COINS_MAX_WIN = 8
const POSTMAN_COINS_MAX_WIN = 10
const TECHLEAD_COINS_MAX_WIN = 2


func _ready():
	$insomnia_label.text = String(insomnia_coins)
	$postman_label.text = String(postman_coins)

func _physics_process(delta):
	# check if all maxes are met
	pass

func _on_insomnia_coin_collected():
	insomnia_coins = insomnia_coins + 1
	_ready()


func _on_postman_coin_collected():
	postman_coins = postman_coins + 1
	_ready()

