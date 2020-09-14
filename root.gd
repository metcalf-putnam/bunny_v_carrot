extends Node2D


func _ready():
	$AnimationPlayer.play("title")


func _on_player_player_killed():
	stop()
	$AnimationPlayer.play("death")


func _on_GameOver_restart():
	start()


func _on_boss_killed():
	stop()
	$AnimationPlayer.play("feast")


func _on_carrot_boss_health_updated(new_health):
	if new_health <= 0: 
		_on_boss_killed()
	$ProgressBar.value = new_health


func stop():
	$BossStart/carrot.stop()
	$player.set_inactive()
	$CarrotBombs.stop()
	$Music.stop()


func _on_StartButton_pressed():
	start()
	$StartButton.visible = false


func start():
	$AnimationPlayer.play("normal")
	$Music.play()
	$player.revive()
	$BossStart/carrot.revive()
	$player.position = $PlayerStart.position
	yield(get_tree().create_timer(1), "timeout") # TODO: setup count down
	$BossStart/carrot.start()
