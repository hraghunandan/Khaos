extends KinematicBody

onready var anim = get_node("AnimationPlayer")

var speed = 16
var acc = 15
var vel = Vector3()
var grav = -60
var max_grav = -150

func _ready():
	pass
	
func _process(delta):
	
	var targetDirection = Vector2(0,0);
	if Input.is_action_pressed("forward"):
		targetDirection.x += 1;
	if Input.is_action_pressed("backward"):
		targetDirection.x -= 1;
	if Input.is_action_pressed("left"):
		targetDirection.y -= 1;
	if Input.is_action_pressed("right"):
		targetDirection.y += 1;
		
	set_anim(targetDirection)
	
	targetDirection = targetDirection.normalized()
	
	vel.x = lerp(vel.x, targetDirection.x * speed, acc * delta)
	vel.z = lerp(vel.z, targetDirection.y * speed, acc * delta)
	
	vel.y += grav * delta
	if vel.y < max_grav:
		vel.y = max_grav
		
	vel = move_and_slide(vel, Vector3(0,1,0))
	
	if is_on_floor() and vel.y < 0:
		vel.y = 0
		
func set_anim(dir):
	
	#if dir == Vector2(0,0):
		#anim.play("default")
	
	if dir == Vector2(0,1):
		anim.play("default")
	elif dir == Vector2(0,1):
		anim.play("default")
	elif dir == Vector2(1,1):
		anim.play("default")
	elif dir == Vector2(-1,1):
		anim.play("default")
	elif dir == Vector2(1,0):
		anim.play("default")
	elif dir == Vector2(0,-1):
		anim.play("default")
	elif dir == Vector2(1,-1):
		anim.play("default")
	elif dir == Vector2(-1,1):
		anim.play("default")
	

	
	


func _on_Area_body_entered(body):
	if body.name == "KinematicBody":
		get_tree().change_scene("res://gameover.tscn")
