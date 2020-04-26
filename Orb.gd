extends Spatial

func _on_Area_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT and event.pressed == true:
			get_node("scene").hide()
			get_node("../OrbTable").show()