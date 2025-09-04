## You can download demo splash screen here
## https://github.com/duongvituan/godot-awesome-splash
## Import a demo AweSplashScreen you like to your project.
## Drag and drop it to SplashContainer.
@icon("res://addons/awesome_splash/assets/icon/splash_container_icon.png")
@tool
extends "res://addons/awesome_splash/core/BaseSplashContainer.gd"
class_name SplashContainer


func _ready():
	super._ready()
	if not Engine.is_editor_hint():
		finished_all.connect(self._on_finished_all_splash_screen)
		start_play_list_screen()


func _skip_awe_splash_by_event(event) -> bool:
	return event.is_pressed() \
		and ((event is InputEventMouseButton and event.button_index == 1) \
		or (event is InputEventScreenTouch))


# Todo: move to other screen here:
func _on_finished_all_splash_screen():
	get_tree().change_scene_to_file("res://cenas/title_screen.tscn")
