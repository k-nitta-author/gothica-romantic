class_name Game
extends Node2D

const GRID_SIZE = 16 # potentially subject to change
const GRAVITY = 1 # determine best value later on

@onready var hudLayer = $HudLayer
@onready var music: AudioStreamPlayer = $Music
@onready var stage: Stage = $Stage

@export_file("*.tscn") var currentStageFilePath : String

func start_stage():
	stage = load_stage(currentStageFilePath)
	add_child(stage)

func load_stage(file_path: String) -> Stage:

	var stageFile : PackedScene = load(file_path)

	return stageFile.instantiate()

func unload_stage() -> void:
	stage.call_deferred("queue_free")
	stage = null
