class_name BaseManager
extends Node2D

# reference to stage
var stage: Stage

# load deps into this and child classes
func bind_dependencies(stage: Stage):
	self.stage = stage
