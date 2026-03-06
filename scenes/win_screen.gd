extends Sprite2D


func _ready() -> void:
	if LevelManager.current_level == "Level1":
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://scenes/Level2.tscn")
