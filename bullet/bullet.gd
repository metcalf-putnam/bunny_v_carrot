extends RigidBody2D
var damage := 20


func _ready():
	$AudioStreamPlayer2D.play()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
