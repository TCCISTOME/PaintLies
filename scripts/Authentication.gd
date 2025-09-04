extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	
	#if Firebase.Auth.check_auth_file():
		#%StateLabel.text = "Logged in"
		#get_tree().change_scene_to_file("res://cenas/title_screen.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_login_button_pressed():
	var email = %EmailLineEdit.text
	var password = %PasswordLineEdit.text
	Firebase.Auth.login_with_email_and_password(email, password)
	$TextureRect/HBoxContainer2/VBoxContainer/HBoxContainer/VBoxContainer2/StateLabel["theme_override_font_sizes/font_size"] = 10
	$TextureRect/HBoxContainer2/VBoxContainer/HBoxContainer/VBoxContainer2/StateLabel.text = "Logging in"

func _on_signup_button_pressed():
	var email = %EmailLineEdit.text
	var password = %PasswordLineEdit.text
	Firebase.Auth.signup_with_email_and_password(email, password)
	%StateLabel["theme_override_font_sizes/font_size"] = 40
	%StateLabel.text = "Singing up"

func on_login_succeeded(auth):
	print(auth)
	%StateLabel["theme_override_font_sizes/font_size"] = 40
	%StateLabel.text = "Login success!"
	Global.email=auth["email"];
	Firebase.Auth.save_auth(auth)
	get_tree().change_scene_to_file("res://cenas/title_screen.tscn")
	
func on_signup_succeeded(auth):
	print(auth)
	%StateLabel["theme_override_font_sizes/font_size"] = 40
	%StateLabel.text = "Sign up success!"
	Global.email=auth["email"];
	Firebase.Auth.save_auth(auth)
	get_tree().change_scene_to_file("res://cenas/title_screen.tscn")
	
func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	%StateLabel["theme_override_font_sizes/font_size"] = 15
	%StateLabel.text = "Login failed. Error: %s" % message
	
func on_signup_failed(error_code, message):
	print(error_code)
	print(message)
	%StateLabel["theme_override_font_sizes/font_size"] = 15
	%StateLabel.text = "Sign up failed. Error: %s" % message


func _on_email_line_edit_focus_entered() -> void:
	%EmailLineEdit["theme_override_colors/font_placeholder_color"] = "#0000004a"


func _on_email_line_edit_focus_exited() -> void:
	%EmailLineEdit["theme_override_colors/font_placeholder_color"] = "#000000"


func _on_password_line_edit_focus_entered() -> void:
	%PasswordLineEdit["theme_override_colors/font_placeholder_color"] = "#0000004a"


func _on_password_line_edit_focus_exited() -> void:
	%PasswordLineEdit["theme_override_colors/font_placeholder_color"] = "#000000"
