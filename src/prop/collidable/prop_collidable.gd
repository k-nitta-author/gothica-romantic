class_name PropCollidable
extends StaticBody2D

@onready var collisionShape2D: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var anim : AnimationPlayer = $anim

func on_triggered() -> void: pass

func bind_dependencies(stage) -> void: pass