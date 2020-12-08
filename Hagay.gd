extends KinematicBody2D

var velocity = Vector2(0, 0)
export var direction = 1
export var detect_edges = true

const GRAVITY = 20
const SPEED = 100

func _ready():
	$AnimatedSprite.flip_h = (false if direction == 1 else true)
	$RayCast2D.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$RayCast2D.enabled = detect_edges
	

func apply_gravity():
	if not is_on_floor():
		velocity.y += GRAVITY
	
func wall_collide():
	if is_on_wall() or not $RayCast2D.is_colliding() and detect_edges and is_on_floor():
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$RayCast2D.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
func _physics_process(delta):
	apply_gravity()
	wall_collide()
		
	velocity.x = SPEED * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)
