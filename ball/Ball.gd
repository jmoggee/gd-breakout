extends KinematicBody2D

signal tile_hit(body)

var direction = Vector2(0, -1.0)
var speed = 200
var speed_increment = 3
var rng = RandomNumberGenerator.new()

onready var hit_sound = $HitSound
onready var bounce_sound = $BounceSound

func _ready():
	set_initial_direction()

func _physics_process(delta):
	var collide = move_and_collide(direction * speed * delta)
	
	if collide is KinematicCollision2D and collide.collider is Node:
		var collider = collide.collider
		
		if collider.is_in_group("tile"):
			bounce_from_tile(collide)
		elif collider.is_in_group("paddle"):
			bounce_from_paddle(collide)
		elif collider.is_in_group("wall"):
			direction.x *= -1
		elif collider.is_in_group("roof"):
			direction.y *= -1

func set_initial_direction():
	direction.y = -1
	rng.randomize()
	direction.x = rng.randf_range(-1.0, 1.0)

func bounce_from_tile(collide):
	direction.y *= -1
	speed += speed_increment
	emit_signal("tile_hit", collide.collider)
	
	hit_sound.play()
	
func bounce_from_paddle(collide):
	var collider = collide.collider
	var collision_position = collide.position - collider.position
	
	direction.x = collision_position.x / 60
	direction.y *= -1
	
	bounce_sound.play()
