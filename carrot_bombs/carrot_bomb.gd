extends Area2D
var player

var damage := 15


func _on_warning_end():
	$AnimationPlayer.play("explode")


func _on_explosion():
	if player:
		player.hit(damage)
	queue_free()



func _on_CarrotBomb_body_entered(body):
	if body.is_in_group("player"):
		player = body


func _on_CarrotBomb_body_exited(body):
	if body.is_in_group("player"):
		player = null
