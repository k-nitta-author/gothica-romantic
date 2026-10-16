class_name BaseBackground
extends Node2D

@export var parallaxLayers : Array[NodePath]

func _ready() -> void:

    start_layers()

func start_layers() -> void:
    for layer in parallaxLayers: get_node(layer).stopped = true 

func stop_layers() -> void:
    for layer in parallaxLayers: get_node(layer).stopped = true