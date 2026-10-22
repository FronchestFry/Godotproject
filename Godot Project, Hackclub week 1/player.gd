extends CharacterBody3D

var SPEED = 7
var GRAVITY = 12
var JUMP_FORCE = 8
var WALL_JUMP_FORCE = 20
var DASH_FORCE = 20
var SENSITIVITY = .007
var dash_cooldown = false
var Horizontal_velocity = Vector3(0,0,0)
var Acc = 30
var Dec = 10
var rate = 1
var player_mass = 80
var pull_strength = 1000
var pull_damping = 100
var max_pull_force = 5000

@onready var Head = $Neck/Head
@onready var Body = $"."
@onready var anchor = get_parent().get_node('Anchor')


func _physics_process(delta: float) -> void:
	#Basic movement code
		#Technically borrowed from an older project of mine, though it's re-typed, not copy pasted
		#Not sure why that'd matter honestly I just felt like saying it
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y))
	#Normal Jump
	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y += JUMP_FORCE
		
	
	#Wall Jump
	if is_on_wall_only() and Input.is_action_just_pressed("Jump"):
		#Uppies
		velocity.y += JUMP_FORCE
		#Move away from wall so you don't spam space to rocket up
		velocity += get_last_slide_collision().get_normal() * WALL_JUMP_FORCE

	#actually move when I set the move
	var target_velocity = direction * SPEED
	rate = Acc if direction.length_squared() > 0.0 else Dec
	Horizontal_velocity = Vector3(velocity.x, 0, velocity.z)
	Horizontal_velocity = Horizontal_velocity.move_toward(target_velocity, rate * delta)

	velocity.x = Horizontal_velocity.x
	velocity.z = Horizontal_velocity.z
	
	#Dash
	if Input.is_action_just_pressed("Dash") and dash_cooldown == false:
		#Can't dash until on floor
		dash_cooldown = true
		velocity += -Head.get_global_transform().basis.z * DASH_FORCE
		
	#Ironpulling
	if Input.is_action_pressed("Pull"):
		var anchor_pull_dir = Body.get_global_position() - anchor.get_global_position()
		var distance = anchor_pull_dir.length()
		if distance > 1.5:
			var dir = anchor_pull_dir / distance
			var pull_speed = (velocity - anchor.linear_velocity).dot(dir)
			var force = clamp(pull_strength * 5 + pull_damping * pull_speed, 0, max_pull_force)
			var force_on_anchor = dir * force
			anchor.apply_central_force(force_on_anchor)
			velocity -= force_on_anchor / player_mass * delta
		
	elif Input.is_action_pressed("Push"):
		var anchor_push_dir = Body.get_global_position() - anchor.get_global_position()
		var distance = anchor_push_dir.length()
		if distance > 1.5:
			var dir = anchor_push_dir / distance
			var push_speed = (anchor.linear_velocity - velocity).dot(dir)
			var force = clamp(pull_strength * 5 + pull_damping * push_speed, 0, max_pull_force)
			var force_on_anchor = -dir * force
			anchor.apply_central_force(force_on_anchor)
			velocity -= force_on_anchor / player_mass * delta
			print("Push force: ", force, "  Player velocity: ", velocity)
		
	
	#Regain dash on floor
	if is_on_floor():
		dash_cooldown = false
		Dec = 20
	else:
		Dec = 10
	
	#gravity
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	
	#Glowing anchor lines
	
	
	move_and_slide()

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		Body.rotate_y(-event.relative.x * SENSITIVITY)
		Head.rotate_x(-event.relative.y * SENSITIVITY)
		Head.rotation.x = clamp(Head.rotation.x, deg_to_rad(-70), deg_to_rad(70))
