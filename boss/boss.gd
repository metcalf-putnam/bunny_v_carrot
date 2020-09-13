extends RigidBody2D
var rotation_offset := 90 # degrees
var rotation_step := 20
var bullet_rotation = 0
export (PackedScene) var Bullet
export (NodePath) var player_path
var Player
var bullet_speed = 350
var turn_speed = PI*2/3
var desired_rotation

func _ready():
	if player_path:
		Player = get_node(player_path)
	else:
		print("error: player not found by boss!")


func _on_Timer_timeout():
	pass
	#shoot()
	#$AnimationPlayer.play("shoot")


func shoot():
	var bullet = Bullet.instance()
	add_child(bullet)
	# TODO: work in radians so don't need to do a deg2rad function call?
	bullet.linear_velocity = Vector2(bullet_speed, 0).rotated(deg2rad(bullet_rotation))
	bullet.rotation_degrees = bullet_rotation + rotation_offset
	bullet_rotation = (bullet_rotation + rotation_step) % 360 


func _process(delta):
	desired_rotation = rotation
	
	var turn_rotation_max = turn_speed * delta
	var player_angle = get_angle_to(Player.global_position)
	if abs(player_angle) <= turn_rotation_max:
		desired_rotation = rotation + player_angle
	elif player_angle > 0:
		desired_rotation = rotation + turn_rotation_max
	else:
		desired_rotation = rotation - turn_rotation_max
	_integrate_forces(rotation)

func _integrate_forces(state):
	state = desired_rotation

func start():
	$Timer.start()


func stop():
	$Timer.stop()
	

func _on_quick_volley():
	apply_central_impulse(Vector2(-50, 0))
	var bullet = Bullet.instance()
	get_tree().get_root().add_child(bullet)
	bullet.global_position = $GunTip.global_position
	bullet.linear_velocity = Vector2(bullet_speed, 0).rotated(rotation)
	bullet.rotation_degrees = rotation_degrees + rotation_offset
