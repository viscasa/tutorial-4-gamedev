extends CharacterBody2D

signal life_changed(new_life: int)

const ACCELERATION = 400.0
const DECELERATION = 400.0

@export var speed: float = 600
@export var gravity: int = 1200
@export var jump_speed: int = -400
var life_count: int = 3

@onready var particle = $GPUParticles2D

func _ready() -> void:
	life_changed.emit(life_count)

func get_input():
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
	if Input.is_action_pressed("right"):
		$Sprite2D.flip_h = false
		velocity.x = lerp(velocity.x, speed, ACCELERATION / speed)  ## naik perlahan (kanan)
	elif Input.is_action_pressed("left"):
		$Sprite2D.flip_h = true
		velocity.x = lerp(velocity.x, -speed, ACCELERATION / speed)  ## naik perlahan (kiri)
	else:
		velocity.x = lerp(velocity.x, 0.0, DECELERATION / speed)  ## turun perlahan


func set_particles():
	if abs(velocity.x) >= speed - 1.0 and is_on_floor():
		particle.set_emitting(true)
	else:
		particle.set_emitting(false)

func _physics_process(delta):
	velocity.y += delta * gravity
	get_input()
	set_particles()
	move_and_slide()


func _process(_delta):
	if not is_on_floor():
		$Animator.play("Jump")
	elif abs(velocity.x) > 10.0:  # use abs/threshold since it interpolates towards 0
		$Animator.play("Walk")
	else:
		$Animator.play("Idle")


func _on_hit_box_body_entered(body: Node2D) -> void:
	var is_hazard = body is FallingFish or body is FallingSaw
	await RenderingServer.frame_post_draw
	if is_hazard:
		if life_count == 1:
			life_count = 3
			get_tree().change_scene_to_file("res://scenes/LoseScreen.tscn")
		else :
			life_count -= 1
			life_changed.emit(life_count)
