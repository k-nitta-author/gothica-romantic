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

# get reference to singular noedes
@onready var player = $ActorManager.player
@onready var stage_exit = $StageExit

@onready var shoot_splatter = preload("uid://bjjv01r2sxehu")
@onready var slash_splatter = preload("uid://dam2cxs8um8t1")

@export var transition_in : EffectsLayer.TRANS
@export var transition_out : EffectsLayer.TRANS

var current_checkpoint_idx : int

var game: Game

signal stage_end()
signal notify_save()

func _ready() -> void:

	start()
	bind_dependencies(self)

# get the current boss
func get_boss() -> Array: return actorManager.get_bosses()

# get the current player
func get_player() -> Player: return player

func bind_to_game(_game: Game) -> void:
	self.game = _game
	await ready
	stage_exit.connect("player_exited", end)
	checkPointManager.bind_dependencies(self, _game)

	connect("notify_save", game.save)

# bind self and necessary references to the various managers
func bind_dependencies(stage: Stage):
	actorManager.bind_dependencies(stage)
	propManager.bind_dependencies(stage)
	bulletManager.bind_dependencies(stage)

# the process of starting the level
func start() -> void:
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

# spawn actor
func spawn_actor(actorScene: PackedScene) -> void:
	actorManager.add_child(actorScene.instantiate())

# spawn a given effect at this location
func spawn_effects(pos: Vector2, is_flipped: int, splatter_type: SPLATTER) -> void:

	var splatter

	match splatter_type:
		SPLATTER.SLASH: splatter = slash_splatter.instantiate()
		SPLATTER.SHOOT: splatter = shoot_splatter.instantiate()

	splatter.global_position = pos

	if !is_flipped: splatter.scale.x  *= -1

	add_child(splatter)

# called when a breakable prop or enemy is destroyed
func spawn_collectible(node: Node) -> void:

	randomize()

	var random_number := randi_range(0, 6)

	var drop : int

	if random_number == 1: drop = propManager.DROPS.HP

	elif random_number == 2: drop = propManager.DROPS.BULLET

	else: drop = propManager.DROPS.NONE

	var dropPos : Vector2 = node.get_eye_level()
	
	propManager.add_collectible(drop, dropPos)

# called when player passes checkpoint
func on_player_checkpoint_activated(_checkpointIdx: int) -> void:
	current_checkpoint_idx = _checkpointIdx

	print(_checkpointIdx)
	emit_signal("notify_save")
