class_name Stage
extends Node2D

@onready var tileMapLayer = $TileMapLayer
@onready var anim : AnimationPlayer = $anim

@onready var actorManager = $ActorManager
@onready var propManager = $PropManager
@onready var bulletManager = $BulletManager

@onready var player = $ActorManager.player
@onready var stage_exit = $StageExit

var game: Game

signal stage_end()

func _ready() -> void:
	bind_dependencies(self)
	
func bind_to_game(game: Game) -> void:
	self.game = game
	# stage_exit.connect("player_exited", game.on_player_exited)

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

func spawn_collectible(node: Node) -> void:

	randomize()

	var random_number := randi_range(0, 6)

	var drop : int

	if random_number == 1: drop = propManager.DROPS.HP

	elif random_number == 2: drop = propManager.DROPS.BULLET

	else: drop = propManager.DROPS.NONE

	var dropPos : Vector2 = node.get_eye_level()
	
	propManager.add_collectible(drop, dropPos)
