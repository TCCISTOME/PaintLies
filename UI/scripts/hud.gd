extends Control
@onready var xp_counter: Label = $container/xp_container/xp_counter as Label
@onready var timer_counter: Label = $container/timer_container/timer_counter as Label
@onready var potion_counter: Label = $container/potion_container/potion_icon/potion_counter as Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	xp_counter.text = str("%03d" % Global.countXp)
	xp_counter.text = str("%04d" % Global.countTimer)
	xp_counter.text = str("%02d" % Global.countPotion)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	xp_counter.text = str("%03d" % Global.countXp)
	
	
	
