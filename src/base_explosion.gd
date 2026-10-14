class_name BaseExplosion
extends Area2D

@export var duration := 0.0

@onready var sprite : Sprite2D = $Sprite2D
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var collision_shape : CollisionShape2D = $CollisionShape2D

@onready var t := get_tree().create_timer(duration) 


func _ready() -> void: t.connect("timeout", on_timer_timeout)

func on_timer_timeout() -> void: call_deferred("queue_free")




