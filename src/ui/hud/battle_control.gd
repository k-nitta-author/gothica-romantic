extends Control

@onready var BossHpBar: Sprite2D = $BossHpBar
@onready var BossHpBarLabel = $"BossHpBar/small label2"
@onready var BossHpProgressBar = $EnemyHpBar

@onready var playerHpBar : ProgressBar = $PlayerHpBar
@onready var enemyHpBar : ProgressBar = $EnemyHpBar

@onready var bulletBar: Control = $BulletBar
@onready var potionIcons: Control = $potionIcons

func bind_to_player(p: Player):
	p.connect("has_hp_changed", update_hp_bar)
	p.connect("on_bullets_current_change", bulletBar.update_bullet_bar)
	p.connect("on_potions_current_change", potionIcons.update_potion_icons)

func update_hp_bar(_actor: BaseActor, _old_value: int, current_hp: int): playerHpBar.value = current_hp

func reset() -> void:
	playerHpBar.value = 8
	BossHpProgressBar.value = BossHpProgressBar.max_value
	bulletBar.update_bullet_bar(0, 6)
	potionIcons.reset()


func bind_boss_hp_bar(boss: BaseActor) -> void:
	BossHpProgressBar.max_value = boss.max_hp
	BossHpProgressBar.value = boss.current_hp
	BossHpBarLabel.text = boss.name
	boss.connect("has_hp_changed", update_boss_hp_bar)

func toggle_boss_hp_bar_visible() -> void:
	BossHpBar.visible = true
	BossHpProgressBar.visible = true

func update_boss_hp_bar(_actor: BaseActor, _old_hp: float, new_hp: float) -> void:
	BossHpProgressBar.value = new_hp
	BossHpBar.visible = new_hp != 0
