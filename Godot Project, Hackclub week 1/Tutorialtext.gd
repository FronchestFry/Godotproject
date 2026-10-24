extends Label3D
var pulled = false
var pushed = false
var uped = false
var downed = false



func _physics_process(delta: float) -> void:
	if pulled == true and pushed == true and uped == true and downed == true:
		text = "Good. You now have the basics. Launch yourself up to the platform behind you, and we shal continue your trial"
	elif pulled == true and pushed == true:
		text = "Good job. You we might make a Fogsired of you yet. \n Use your scroll wheel to increase the amount of force you push with.\n You can see the curent force value in the top left."
	elif pulled == false and pushed == false:
		text = "This is your coin. \n Get to know it well, as it will be the source of your power. \n Right Click to push against your bond, left click to pull on it. \n The force aplies to both of you, but the coin is lighter, so if it can move, it likely will. \n If it can't, it moves you."

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Push"):
		pushed = true
	if Input.is_action_just_pressed("Pull"):
		pulled = true
	if Input.is_action_just_pressed("Alo_force_up"):
		uped = true
	if Input.is_action_just_pressed("Alo_force_down"):
		downed = true
