extends RigidBody2D
class_name FallingFish

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1

func _on_body_entered(body: Node) -> void:
	if body is TileMapLayer or body is TileMap:
		queue_free()
