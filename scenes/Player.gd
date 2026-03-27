extends CharacterBody2D

signal life_changed(new_life: int)

@export var speed: int = 400
@export var gravity: int = 1200
@export var jump_speed: int = -400
var life_count: int = 3

func _ready() -> void:
	life_changed.emit(life_count)

func get_input():
	velocity.x = 0
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
	if Input.is_action_pressed("right"):
		velocity.x += speed
	if Input.is_action_pressed("left"):
		velocity.x -= speed


func _physics_process(delta):
	velocity.y += delta * gravity
	get_input()
	move_and_slide()


func _process(_delta):
	if not is_on_floor():
		$Animator.play("Jump")
	elif velocity.x != 0:
		$Animator.play("Walk")
	else:
		$Animator.play("Idle")

	if velocity.x != 0:
		if velocity.x > 0:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true


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
