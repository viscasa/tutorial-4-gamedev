extends Node2D

@export var level_name: String = "Level1"


func _ready() -> void:
	LevelManager.current_level = level_name
