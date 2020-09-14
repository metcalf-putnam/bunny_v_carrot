extends KinematicBody2D
var rotation_offset := 90 # degrees
var rotation_step := 20
var bullet_rotation = 0
export (PackedScene) var Bullet
export (NodePath) var player_path
var Player
var bullet_speed = 350
var turn_speed = PI*2/3
var desired_rotation
var health := 100
signal boss_health_updated


func _ready():
	$AnimationPlayer.play("idle")
	emit_signal("boss_health_updated", health)
	if player_path:
		Player = get_node(player_path)
	else:
		print("error: player not found by boss!")


func _on_Timer_timeout():
	pass
	$AnimationPlayer.play("shoot")
	#spiral_shoot()


func take_damage(damage : float):
	$AudioStreamPlayer.play()
	health -= damage
	emit_signal("boss_health_updated", health)


func spiral_shoot():
	var bullet = Bullet.instance()
	get_tree().get_root().add_child(bullet)
	bullet.global_position = $GunTip.global_position
	bullet.linear_velocity = Vector2(bullet_speed, 0).rotated(rotation)
	bullet.rotation_degrees = bullet_rotation + rotation_offset
	bullet_rotation = (bullet_rotation + rotation_step) % 360 


func _process(delta):
	var turn_rotation_max = turn_speed * delta
	var player_angle = get_angle_to(Player.global_position)
	
	if abs(player_angle) <= turn_rotation_max:
		rotation = rotation + player_angle
	elif player_angle > 0:
		rotation = rotation + turn_rotation_max
	else:
		rotation = rotation - turn_rotation_max


func start():
	$Timer.start()


func revive():
	health = 100 
	emit_signal("boss_health_updated", health)


func stop():
	$Timer.stop()
	

func _on_quick_volley():
	# TODO: make prettier
	# middle
	var bullet = Bullet.instance()
	get_tree().get_root().add_child(bullet)
	bullet.global_position = $GunTip.global_position
	bullet.linear_velocity = Vector2(bullet_speed, 0).rotated(rotation)
	bullet.rotation_degrees = rotation_degrees + rotation_offset

	# left
	bullet = Bullet.instance()
	get_tree().get_root().add_child(bullet)
	bullet.global_position = $GunTip/PosLeft.global_position
	bullet.linear_velocity = Vector2(bullet_speed, 0).rotated(rotation-PI/4)
	bullet.rotation_degrees = rotation_degrees + rotation_offset
	
	# right
	bullet = Bullet.instance()
	get_tree().get_root().add_child(bullet)
	bullet.global_position = $GunTip/PosRight.global_position
	bullet.linear_velocity = Vector2(bullet_speed, 0).rotated(rotation+PI/4)
	bullet.rotation_degrees = rotation_degrees + rotation_offset
