extends TextureProgress



onready var health_bar = get_node("../HealthBar")
onready var health_bar_under = get_node("../HealthBarUnder")
onready var health_tween = get_node("../HealthTween")

export (Color) var healthy_color = Color.green
export (Color) var caution_color = Color.yellow
export (Color) var danger_color = Color.red
export (float, 0, 1, 0.05) var caution_zone = 0.6
export (float, 0, 1, 0.05) var danger_zone = 0.3

func _on_health_updated(health):
	health_bar.value = health
	health_tween.interpolate_property(health_bar_under, "value", health_bar_under.value, health, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	health_tween.start()
	
	_assign_color(health)
	
func _assign_color(health):
	if health < health_bar.max_value * danger_zone:
		health_bar.tint_progress = danger_color
	elif health < health_bar.max_value * caution_zone:
		health_bar.tint_progress = caution_color
	else:
		health_bar.tint_progress = healthy_color

func _on_fallenGod_damage(health):
	_on_health_updated(health)
