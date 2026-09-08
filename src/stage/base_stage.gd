class_name Stage
extends Node2D

enum SPLATTER {SHOOT, SLASH}

@onready var tileMapLayer = $TileMapLayer
@onready var anim : AnimationPlayer = $anim

# declare all managers
@onready var actorManager = $ActorManager
@onready var propManager = $PropManager
@onready var bulletManager = $BulletManager
@onready var checkPointManager = $CheckPointManager
@onready var effectsManager = $EffectsManager

# get reference to singular noedes
@onready var player = $ActorManager.player
@onready var stage_exit = $StageExit

@onready var shoot_splatter = preload("uid://bjjv01r2sxehu")
@onready var slash_splatter = preload("uid://dam2cxs8um8t1")

@export var transition_in : EffectsLayer.TRANS
@export var transition_out : EffectsLayer.TRANS

@onready var stageCamera : Camera2D = $Camera2D

var current_checkpoint_idx : int

var game: Game

signal stage_end()
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

# bind relevant variables to the stage
func bind_to_game(_game: Game) -> void:
	self.game = _game

	# variables that can only be bound on ready
	await ready
	stage_exit.connect("player_exited", end)
	checkPointManager.bind_dependencies(self, _game)

	connect("notify_save", game.save)

# bind self and necessary references to the various managers
func bind_dependencies(stage: Stage):
	actorManager.bind_dependencies(stage)
	propManager.bind_dependencies(stage)
	bulletManager.bind_dependencies(stage)
	stageCamera.bind_dependencies(stage)

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
func end(nextLevel: PackedScene) -> void:

	actorManager.can_update = false

	game.effectLayer.play_transition(transition_out)

	await game.effectLayer.transition_finished

	game.on_stage_end(nextLevel)

# called when player passes checkpoint
func on_player_checkpoint_activated(_checkpointIdx: int) -> void:
	current_checkpoint_idx = _checkpointIdx

	emit_signal("notify_save")


func _physics_process(delta: float) -> void:
	stageCamera.update()
