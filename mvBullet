extends Area2D

export var time_desaparace = 0
#direccion
export var direccion = Vector2(1, 0)
export var velocidad = 300

func _ready():
	set_process(true)

func _process(delta):	
	translate((direccion*velocidad)* delta)
	
	#for cuerpo in cuerpos:
	#	if !cuerpo.is_in_group("NOmuere"):
	#		cuerpo.queue_free() 
	#yield(create_timer(time_desaparace), "timeout")
	#queue_free()
	#timer-----
func create_timer(wait_time):
	var timer = Timer.new()
	timer.set_wait_time(wait_time)
	timer.set_one_shot(true)
	timer.connect("timeout", timer, "queue_free")
	add_child(timer)
	timer.start()
	return timer
	pass

