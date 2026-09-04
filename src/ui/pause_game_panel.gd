extends Panel

# intitialize buttons
@onready var resumeButton : Button = $resumeButton
@onready var settingsButton : Button = $settingsButton
@onready var mainMenuButton : Button = $mainMenuButton
@onready var quitMenuButton : Button = $quitMenuButton

@onready var settingsScreen = $SettingsScreen

# all the signals for what to do
signal return_to_previous_screen
signal return_to_main_menu
signal display_settings

func _ready() -> void:
	# connect each button to callback function
	resumeButton.connect("pressed", on_resume_clicked)
	settingsButton.connect("pressed", on_settings_clicked)
	mainMenuButton.connect("pressed", on_main_menu_clicked)
	quitMenuButton.connect("pressed", on_quit_clicked)

	settingsScreen.connect("return_to_previous_screen", settingsScreen.hide)

# called when the resume button is clicked
func on_resume_clicked() -> void: emit_signal("return_to_previous_screen")

# called when the settings button is clicked
func on_settings_clicked() -> void:
	emit_signal("display_settings")
	settingsScreen.show()

# called when the main menu button is clicked
func on_main_menu_clicked() -> void:
	visible = false
	emit_signal("return_to_main_menu")

# called when the quit button is clicked
func on_quit_clicked() -> void: get_tree().quit()