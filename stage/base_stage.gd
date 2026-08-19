class_name Stage
extends Node2D

@onready var tileMapLayer = $TileMapLayer
@onready var anim : AnimationPlayer = $anim

@onready var actorManager = $ActorManager
@onready var propManager = $PropManager
@onready var bulletManager = $BulletManager

func _ready() -> void:
	bind_dependencies(self)

func bind_dependencies(stage: Stage):
	actorManager.bind_dependencies(stage)
	propManager.bind_dependencies(stage)
	bulletManager.bind_dependencies(stage)
