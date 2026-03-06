extends Node2D


func _ready() -> void:
	await get_tree().create_timer(1).timeout
	var level = LevelManager.current_level
	get_tree().change_scene_to_file(str("res://scenes/" + level + ".tscn"))
