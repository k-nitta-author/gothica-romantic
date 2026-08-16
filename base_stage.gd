class_name Stage
extends Node2D

@onready var anim : AnimationPlayer = $anim

@onready var actorManager = $ActorManager
@onready var propManager = $PropManager
@onready var bulletManager = $BulletManager

func bind_dependencies():
    pass