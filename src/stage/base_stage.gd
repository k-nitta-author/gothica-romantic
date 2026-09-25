class_name Stage
extends Node2D

enum EXIT_TYPE {TO_NEXT_STAGE, TO_INTERIOR, TO_EXTERIOR}

@onready var tileMapLayer = $TileMapLayer
@onready var anim : AnimationPlayer = $anim

# declare all managers
@onready var actorManager = $ActorManager
@onready var propManager = $PropManager
@onready var bulletManager = $BulletManager
@onready var checkPointManager = $CheckPointManager
@onready var effectsManager = $EffectsManager
@onready var exitManager = $ExitManager

# get reference to singular noedes
@onready var player: Player = $ActorManager.player

# tranistion types for in and out
@export var transition_in : EffectsLayer.TRANS
@export var transition_out : EffectsLayer.TRANS

# the stage camera
@onready var stageCamera : Camera2D = $Camera2D

# the current checkpoint that the player has reached
var current_checkpoint_idx : int

# a reference to the game
var game: Game

signal notify_save()

func _ready() -> void:
	# start the level
	start()
	
	# bind all dependencies as necessary
	bind_dependencies(self)

# get the current boss
func get_boss() -> Array: return actorManager.get_bosses()

# get the current player
func get_player() -> Player: return player

func set_player_at_checkpoint() -> Stage:

	var check_point = checkPointManager\
	.get_checkpoint_by_idx(current_checkpoint_idx)
	
	if check_point == null:
		return null

	player.global_position = check_point.global_position

	return self

func set_player_at_door_idx(door_idx: int) -> Stage:

	print(exitManager)

	player.global_position = exitManager\
	.get_stage_door_by_idx(door_idx)\
	.global_position

	return self


func load_game(data: Dictionary) -> Stage:

	player.load_game(data)

	return self

# bind relevant variables to the stage
func bind_to_game(_game: Game) -> Stage:
	game = _game

	await ready

	# set up the hud layer
	game.hudLayer.\
	bind_to_player(player).\
	bind_boss(get_boss())

	connect("notify_save", game.save)

	return self

# bind self and necessary references to the various managers
func bind_dependencies(stage: Stage):
	actorManager.bind_dependencies(stage)
	propManager.bind_dependencies(stage)
	bulletManager.bind_dependencies(stage)
	stageCamera.bind_dependencies(stage)
	exitManager.bind_dependencies(stage)
	checkPointManager.bind_dependencies(stage, game)

# the process of starting the level
func start() -> void:
	# mandatory null check
	if game != null:
		game.effectLayer.play_transition(transition_in, true)

		await game.effectLayer.transition_finished

	actorManager.can_update = true

# the process of ending the level
# probably plays some sort of transition or music queue
# passes up the chain to the game above the next level scene
func end(nextLevel: PackedScene, exit_type: EXIT_TYPE, egress_idx: int) -> void:

	if game == null: return

	actorManager.can_update = false

	game.effectLayer.play_transition(transition_out)

	await game.effectLayer.transition_finished

	game.on_stage_end(nextLevel, exit_type, egress_idx)

# called when player passes checkpoint
func on_player_checkpoint_activated(_checkpointIdx: int) -> void:
	current_checkpoint_idx = _checkpointIdx
	emit_signal("notify_save")

# handle various nodes
func _physics_process(_delta: float) -> void: stageCamera.update()
