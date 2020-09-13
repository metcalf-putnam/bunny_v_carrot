extends RigidBody2D
var damage := 20


func _ready():
	$AudioStreamPlayer.play()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	

func explode():
	linear_velocity = Vector2(0,0)
	$AnimationPlayer.play("explode")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "explode":
		queue_free()
