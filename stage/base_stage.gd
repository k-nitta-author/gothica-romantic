class_name Stage
extends Node2D

@onready var tileMapLayer = $TileMapLayer
@onready var anim : AnimationPlayer = $anim

@onready var actorManager = $ActorManager
@onready var propManager = $PropManager
@onready var bulletManager = $BulletManager

@onready var player = $ActorManager.player

signal stage_end()

func _ready() -> void:
	bind_dependencies(self)

func bind_to_game(_game: Game) -> void:
	pass

func get_player() -> Player: return player

func bind_dependencies(stage: Stage):
	actorManager.bind_dependencies(stage)
	#propManager.bind_dependencies(stage)
	bulletManager.bind_dependencies(stage)

# the process of ending the level
# probably plays some sort of transition or music queue
# passes up the chain to the game above the next level scene
func end(_nextLevel: PackedScene) -> void:
	emit_signal("stage_end")

func spawn_actor(actorScene: PackedScene) -> void:
	actorManager.add_child(actorScene.instantiate())