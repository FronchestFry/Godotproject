extends CharacterBody3D

var SPEED = 7
var GRAVITY = 9.8
var JUMP_FORCE = 8
var DASH_FORCE = 20
var SENSITIVITY = .007
var dash_cooldown = 1
var Horizontal_velocity = 0
var Acc = 20
var Dec = 10

@onready var Head = $Neck/Head
@onready var Body = $"."


func _physics_process(delta: float) -> void:
	#Basic movement code
		#Technically borrowed from an older project of mine, though it's re-typed, not copy pasted
		#Not sure why that'd matter honestly I just felt like saying it
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y))
	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y += JUMP_FORCE
	

	#actually move when I set the move
	if direction:
		var target_velocity = direction * SPEED
		
		Horizontal_velocity = Vector3(velocity.x, 0, velocity.z)
		Horizontal_velocity = Horizontal_velocity.move_toward(target_velocity, rate * delta)
		#decelerate
	else:
		velocity.x = velocity.x * .9
		velocity.z = velocity.z * .9
	
	#Dash
	dash_cooldown += delta
	if Input.is_action_just_pressed("Dash") and dash_cooldown > 1:
		dash_cooldown = 0
		velocity += -Head.get_global_transform().basis.z * DASH_FORCE
	
	#gravity
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	
	move_and_slide()

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		Body.rotate_y(-event.relative.x * SENSITIVITY)
		Head.rotate_x(-event.relative.y * SENSITIVITY)
		Head.rotation.x = clamp(Head.rotation.x, deg_to_rad(-70), deg_to_rad(70))
