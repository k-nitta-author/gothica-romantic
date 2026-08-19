class_name Game
extends Node2D

const GRID_SIZE = 16 # potentially subject to change
const GRAVITY = 1 # determine best value later on

@onready var hudLayer = $HudLayer
@onready var music: AudioStreamPlayer = $Music
@onready var stage: Stage = $Stage

@export var next_level_scene: PackedScene

func start_stage():
	
	var s = load_stage(next_level_scene)
	add_child(s)

func load_stage(nextLevel: PackedScene) -> Stage: return nextLevel.instantiate()

func unload_stage() -> void:
	stage.call_deferred("queue_free")
	stage = null
