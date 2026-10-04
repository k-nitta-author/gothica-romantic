class_name BaseManager
extends Node

# reference to stage
var stage: Stage

# load deps into this and child classes
func bind_dependencies(_stage: Stage):
	self.stage = _stage
