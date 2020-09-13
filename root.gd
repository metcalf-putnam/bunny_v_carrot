extends Node2D


func _ready():
	$GameOver.hide()


func _on_player_player_killed():
	$BossStart/carrot.stop()
	$GameOver.show()
	$player.set_inactive()


func _on_GameOver_restart():
	$GameOver.hide()
	$player.revive()
	$BossStart/carrot.revive()
	$player.position = $PlayerStart.position
	yield(get_tree().create_timer(2), "timeout") # TODO: setup count down
	$BossStart/carrot.start()


func _on_boss_killed():
	$BossStart/carrot.stop()
	$GameOver.show()
	$player.set_inactive()


func _on_carrot_boss_health_updated(new_health):
	if new_health <= 0: 
		_on_boss_killed()
	$ProgressBar.value = new_health
