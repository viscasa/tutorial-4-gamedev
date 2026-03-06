extends RigidBody2D
class_name FallingSaw

@export var rotation_speed: float = 10.0


func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1


func _process(delta: float) -> void:
	rotation += rotation_speed * delta


func _on_body_entered(body: Node) -> void:
	if body is TileMapLayer or body is TileMap or body is StaticBody2D:
		queue_free()
