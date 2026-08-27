class_name CollectibleProp
extends BaseProp

signal collected(collectible: CollectibleProp)

@export var fall_speed := 100

func _ready() -> void:
	super()
	connect("body_entered", on_body_entered)

func on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer: fall_speed = 0

func _physics_process(delta: float) -> void:

	self.global_position.y += fall_speed * delta

func collect() -> void:
	emit_signal("collected", self)

func OnAreaEntered(area: Area2D) -> void:
	super(area)

	collect()
	hitPoints -= 1

