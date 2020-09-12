extends RigidBody2D
var rotation_offset := 90 # degrees
var rotation_step := 20
var bullet_rotation = 0
export (PackedScene) var Bullet
var bullet_speed = 350


func _on_Timer_timeout():
	shoot()


func shoot():
	var bullet = Bullet.instance()
	add_child(bullet)
	# TODO: work in radians so don't need to do a deg2rad function call?
	bullet.linear_velocity = Vector2(bullet_speed, 0).rotated(deg2rad(bullet_rotation))
	bullet.rotation_degrees = bullet_rotation + rotation_offset
	bullet_rotation = (bullet_rotation + rotation_step) % 360 
	

func start():
	$Timer.start()


func stop():
	$Timer.stop()
