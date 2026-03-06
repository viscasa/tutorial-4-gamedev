extends Node2D

@export var obstacle : PackedScene
@export var range:int = 1000
func _ready():
	repeat()

func spawn():
	await RenderingServer.frame_post_draw
	var spawned = obstacle.instantiate()
	get_parent().add_child(spawned)

	var spawn_pos = global_position
	spawn_pos.x = spawn_pos.x + randf_range(-1*range, range)

	spawned.global_position = spawn_pos

func repeat():
	spawn()
	await get_tree().create_timer(1).timeout
	repeat()
