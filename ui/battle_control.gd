extends Control

@onready var BossHpBar: Sprite2D = $BossHpBar
@onready var BossHpBarLabel = $"BossHpBar/small label2"
@onready var BossHpProgressBar = $EnemyHpBar

func bind_boss_hp_bar(boss: BaseActor) -> void:
	BossHpProgressBar.max_value = boss.max_hp
	BossHpProgressBar.value = boss.current_hp
	BossHpBarLabel.text = boss.name
	boss.connect("has_hp_changed", update_boss_hp_bar)


func toggle_boss_hp_bar_visible() -> void:
	BossHpBar.visible = true
	BossHpProgressBar.visible = true

func update_boss_hp_bar(actor: BaseActor, old_hp: float, new_hp: float) -> void:
	BossHpProgressBar.value = new_hp
	BossHpBar.visible = new_hp != 0
