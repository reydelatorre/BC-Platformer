extends KinematicBody2D

var alive = true
var animation_state
var can_shoot = true
var time = 0
var hit_points = 12

onready var animated_sprite = $AnimatedSprite
onready var area2d_top_hit = $Area2D_Top_Hit
onready var raycast2d_player_in_view = $RayCast2D

var animation_utils_instance = animation_utils.new()

const cake_delay = .25 # secs
const CAKE = preload("res://scenes/enemies/Cake.tscn")


func _ready():
	pass


func _on_Area2D_Top_Hit_body_entered(body):
	body.bounce()
	
	alive = false
	
	disable_collisions(4, 0, false)

func _on_AnimatedSprite_animation_finished():
	if !alive:
		queue_free()


func _process(delta):
	animation_state = 'idle'

	time += delta
	if time > cake_delay:
		can_shoot = true
		time = 0
	else:
		can_shoot = false
	
	if raycast2d_player_in_view.is_colliding():
		animation_state = 'fire'
		
		if can_shoot:
			var cake = CAKE.instance()
			get_parent().add_child(cake)
			cake.position = $Position2D.global_position
		
	if alive == false:
		animation_state = 'explode'
		
	animation_utils_instance.process_animation(animated_sprite, animation_state)
		

func disable_collisions(layer_bit, mask_bit, enabled):
	set_collision_layer_bit(layer_bit, enabled)
	set_collision_mask_bit(mask_bit, enabled)
	area2d_top_hit.set_collision_layer_bit(layer_bit, enabled)
	area2d_top_hit.set_collision_mask_bit(mask_bit, enabled)


func damage(amount):
	hit_points -= amount

	if hit_points <= 0:
		$AnimatedSprite.play('explode')
		alive = false