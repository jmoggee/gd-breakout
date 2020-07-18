extends KinematicBody2D

export (int) var speed = 700

func _physics_process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed * delta
		
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed * delta
		
	move_and_collide(velocity)
