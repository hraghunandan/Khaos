extends Spatial

func _on_Area_input_event(camera, event, click_position, click_normal, shape_idx):
	
		if event.button_index == BUTTON_RIGHT and event.pressed == true:
			get_node("../Orb3").hide()
			get_node("../Portal/RootNode (gltf orientation matrix)/RootNode (model correction matrix)/portal_subsFBX/Base/Swirl").show()
