extends Sprite
class_name StreetLight

export (int) var illumination_range := 196

onready var rayCaster := $RayCast2D

func _ready():
	add_to_group(Groups.LIGHTS)

func process_hider(hider: Hider):
	# Cast a ray between the seeker and this hider
	var lookVec = to_local(hider.global_position)
	var distance = lookVec.length()
	
	if distance < illumination_range:
		rayCaster.cast_to = lookVec
		rayCaster.force_raycast_update()
	
		if(rayCaster.is_colliding()):
			var bodySeen = rayCaster.get_collider()
		
			# If the ray hits a wall or something else first, then this Hider is fully occluded
			if(bodySeen == hider):
				var percent_visible = 1.0 - (distance / illumination_range)
				percent_visible = clamp(percent_visible, 0.0, 1.0)
				hider.update_visibility(percent_visible)