extends KinematicBody2D


export var speed = 200
export var dash_speed_multiplier := 3
export var dash_length := .16 # Seconds 

var is_enabled := true
var animationState : AnimationNodeStateMachinePlayback
var health := 100.0
var screen_size
enum State{ACTIVE, DASHING, INACTIVE}
var state = State.ACTIVE
var last_direction = Vector2()
var dash_modulate = Color(.5, .5, .5)
var normal_modulate = Color(1, 1, 1)

signal player_killed


func _ready():
	animationState = $AnimationTree["parameters/playback"]
	$HealthBar.value = health
	screen_size = get_viewport_rect().size


func _physics_process(_delta):
	var direction = Vector2()
	
	match state:
		State.ACTIVE:
			direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
			direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		State.DASHING:
			direction = last_direction 

	if direction.length() > 0:
		update_sprite(direction)
		last_direction = direction
		var velocity = direction.normalized() * speed
		velocity = move_and_slide(velocity)
	else:
		animationState.travel("idle")

	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _input(event):
	if event.is_action_pressed("ui_dash"):
		dash()


func dash():
	# TODO: add trail effect
	state = State.DASHING
	$Sprite.modulate = dash_modulate
	$Tween.interpolate_property(self, "speed", 
			speed * dash_speed_multiplier, speed, dash_length,
			Tween.TRANS_ELASTIC, Tween.EASE_IN)
	$Tween.start()
	yield($Tween, "tween_completed")
	if state == State.INACTIVE:
		return
	state = State.ACTIVE
	$Sprite.modulate = normal_modulate


func update_sprite(direction : Vector2):
	$AnimationTree.set("parameters/idle/blend_position", direction)
	$AnimationTree.set("parameters/walk/blend_position", direction)
	animationState.travel("walk")


func hit(damage):
	$hit_sound.play()
	health -= damage
	$HealthBar.value = health
	if health <= 0:
		emit_signal("player_killed")
		$death_sound.play()


func _on_Area2D_body_entered(body):
	if body.is_in_group("boss_weapon"):
		hit(body.damage)
		body.queue_free()


func set_inactive():
	state = State.INACTIVE
	

func set_active():
	state = State.ACTIVE


func revive():
	set_active()
	health = 100
	$HealthBar.value = health
