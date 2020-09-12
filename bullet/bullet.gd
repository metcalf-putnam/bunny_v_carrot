extends RigidBody2D
var damage := 20


func _ready():
	$AudioStreamPlayer2D.play()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_bullet_body_entered(body):
	print("found the player!")
	if body.is_in_group("player"):
		body.hit(damage)
