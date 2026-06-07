extends CharacterBody2D
var direction_x := 0.0
@export var speed = 170
var can_shoot:= true
var facing_right:= true
var has_gun:=true
signal shoot(pos: Vector2)
	

func _process(delta):
	get_input()
	apply_gravity()
	get_facing_direction()
	get_animation()

	
	velocity.x = direction_x*speed
	move_and_slide()
	
func _on_timer_timeout() -> void:
	can_shoot=true
	print('off CD')

func get_facing_direction():
	if direction_x != 0:
		facing_right = direction_x >= 0

func get_input():
	direction_x=Input.get_axis("left", "right")
	if Input.is_action_just_pressed("1"):
		if has_gun == false:
			has_gun=true
		else:
			has_gun=false
				
	if Input.is_action_just_pressed("shoot"):
		if can_shoot: 
			print ("shoot")
			can_shoot=false
			$Timers/CD.start()
		else:
			print ("is on CD")

func get_animation():
	var animation = 'idle'
	if not is_on_floor():
		animation = 'jump'
	elif direction_x != 0:
		animation = 'walk'
	if has_gun:
		animation += '_gun'
	$AnimatedSprite2D.animation = animation
	$AnimatedSprite2D.flip_h = not facing_right

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -200
		
func apply_gravity():
	velocity.y+=30


func _on_shoot(pos: Vector2) -> void:
	print ('shoot from player')
	print('testing git4')
