extends KinematicBody

signal damage(health)

var camera_angle = 0
var mouse_sensitivity = 0.3

var velocity = Vector3()
var direction = Vector3()

const FLY_SPEED = 40
const FLY_ACCEL = 4


var gravity = -9.8 * 7
const MAX_SPEED = 20
const MAX_RUNNING_SPEED = 30
const ACCEL = 2
const DEACCEL = 6
var health = 5

var jump_height = 20

func _ready():
	pass


func _physics_process(delta):
	
	walk(delta)
	
		

func _input(event):
	if event is InputEventMouseMotion:
		$Head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		
# warning-ignore:unused_variable
		var change = -event.relative.y * mouse_sensitivity
		
		
		
func walk(delta):
	
	direction = Vector3()
	
	var aim = $Head/Camera.get_global_transform().basis
	
	if Input.is_action_pressed("forward"):
		direction -= aim.z
		
	if Input.is_action_pressed("backward"):
		direction += aim.z
		
	if Input.is_action_pressed("left"):
		direction -= aim.x
		
	if Input.is_action_pressed("right"):
		direction += aim.x
		
	direction = direction.normalized()
	
	velocity.y += gravity * delta
	
	var temp_velocity = velocity
	temp_velocity.y = 0
	
	var speed
	if Input.is_action_pressed("sprint"):
		speed = MAX_RUNNING_SPEED
	else:
		speed = MAX_SPEED
	
	var target = direction * speed
	
	var acceleration
	if direction.dot(temp_velocity) > 0:
		acceleration = ACCEL
	else:
		acceleration = DEACCEL
	
	temp_velocity = velocity.linear_interpolate(target, acceleration * delta)
	
	velocity.x = temp_velocity.x
	velocity.z = temp_velocity.z 
	
	velocity = move_and_slide(velocity, Vector3(0,1,0))
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = jump_height
	
		
func fly(delta):
	
	direction = Vector3()
	
	var aim = $Head/Camera.get_global_transform().basis
	
	if Input.is_action_pressed("forward"):
		direction -= aim.z
		
	if Input.is_action_pressed("backward"):
		direction += aim.z
		
	if Input.is_action_pressed("left"):
		direction -= aim.x
		
	if Input.is_action_pressed("right"):
		direction += aim.x
		
	direction = direction.normalized()
	
	var target = direction * FLY_SPEED
	
	velocity = velocity.linear_interpolate(target, FLY_ACCEL * delta)
	
# warning-ignore:return_value_discarded
	move_and_slide(velocity)	


# warning-ignore:unused_argument
func _on_Area2_body_entered(body):
# warning-ignore:return_value_discarded
	if (health == 0):
		get_tree().change_scene("res://gameover.tscn")
	else:
		emit_signal("damage", health)
		health = health - 1
	


#func _on_Area_body_entered(body):
	#get_node("/root/global").hide("res://Main/Orb/Scene")
	#get_tree().change_scene("res://gameover.tscn")
	#if Input.is_action_just_pressed("collect"):
		#get_node("scene").hide()
		#get_node("../OrbTable").show()
		#get_node("../Orb2").show()





# warning-ignore:unused_argument
#func _on_Area_body_entered(body):
#	get_node("Orb/scene").hide()


func _on_Area_body_entered(body):
	get_node("../Orb2").hide()
	get_node("../Orb3").show()


func _on_Area_body1_entered(body):
	get_node("../Orb").hide()
	get_node("../Orb2").show()


func _on_Area_bodyGod_entered(body):
	get_tree().change_scene("res://gameover.tscn")


func _on_Area_bodyIS_entered(body):
	get_tree().change_scene("res://Victory.tscn")
	


func orbTable(body):
	get_node("../OrbTable").hide()


func orbTable2(body):
	get_node("../OrbTable2").hide()


func spikeBall(body):
	get_node("../Orb3").hide()
	get_node("../Portal/Swirl").show()



func _on_hellDog_body_entered(body):
	if (health == 0):
		get_tree().change_scene("res://gameover.tscn")
	else:
		emit_signal("damage", health)
		health = health - 1
