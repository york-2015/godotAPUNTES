extends KinematicBody2D
#bala
const bala = preload("res://bala_esenario.tscn")
#bala 
const UP = Vector2(0, -1)
const GRAVEDADA = 20
const ACELERACION = 50
const VELOCIDAD_MAX = 200
const SALTO_ALTO = -500

#balas
export var velocidadBALA = 300
var velo = velocidadBALA*1.5
var posicion_tiro = "bocaGATO/RIGHT1"
var posi = "bocaGATO/RIGHT1"
var dir = Vector2(1,0)
#vidas
export var vidas = 1
#movimientos ---------------------
var motion = Vector2()

func _physics_process(delta):
	
	#-----------CONTROLES 
	motion.y += GRAVEDADA
	var friction = false
	if Input.is_action_pressed("ui_right"):
		posi = "bocaGATO/RIGHT1"
		dir = Vector2(1,0)
		motion.x = min(motion.x + ACELERACION, VELOCIDAD_MAX)
		posicion_tiro = "bocaGATO/RIGHT1"
	elif Input.is_action_pressed("ui_left"):
		posi = "bocaGATO/LEFT1"
		dir = Vector2(-1,0)
		motion.x = max(motion.x-ACELERACION, -VELOCIDAD_MAX)
		posicion_tiro = "bocaGATO/LEFT1"
	else:
		friction = true

	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = SALTO_ALTO
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
		
	motion = move_and_slide(motion, UP)
	#ACTIVAR DISPARAR ----------------------------------
	if Input.is_action_just_pressed("ui_select") and Input.is_action_pressed("ui_left"):
		sc_disparar(dir, posi, velo)
		
	elif Input.is_action_just_pressed("ui_select") and Input.is_action_pressed("ui_right"):		
		sc_disparar(dir, posicion_tiro, velo)
		
	else:
		if Input.is_action_just_pressed("ui_select"):
			#var dir = Vector2(1,0)
			sc_disparar(dir, posi, velocidadBALA)
			
#DISPARAR -------------------------	
func sc_disparar(dir,strPOSITION,velo):
	var MIUA_POSICION = get_node(strPOSITION).get_global_position()
	crear_bala(MIUA_POSICION, dir, velo)
	#eliminar de del cache
	yield(create_timer(0.25), "timeout")
	
func crear_bala(pos, dir, velo):
	var balapun = bala.instance()
	balapun.position = pos
	balapun.direccion = dir
	balapun.velocidad = velo

	_main_node().add_child(balapun)	

#consegue el root 
func _main_node():
	var root = get_tree().get_root()
	return root.get_child(root.get_child_count()-1)


#---------------------------------
#creador de timer
	
func create_timer(wait_time):
	var timer = Timer.new()
	timer.set_wait_time(wait_time)
	timer.set_one_shot(true)
	timer.connect("timeout", timer, "queue_free")
	add_child(timer)
	timer.start()
	return timer
	pass
	
	
	
	
