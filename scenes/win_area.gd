extends Area2D

@export var sceneName: String = "Level1"

func _on_body_entered(body: Node2D) -> void:
	await RenderingServer.frame_post_draw
	if body.get_name() == "Player":
		get_tree().change_scene_to_file(str("res://scenes/" + sceneName + ".tscn"))
