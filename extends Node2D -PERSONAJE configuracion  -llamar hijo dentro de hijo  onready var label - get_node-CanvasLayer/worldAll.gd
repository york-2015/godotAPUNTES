extends Node2D
#PERSONAJE configuracion 

onready var label = get_node("CanvasLayer/sc_pausa")


#vidas jugador ------------------------------------------------------------------------------------------------vidas
var offset_vida = 40
var vidas_player = 3 
#crea un export de un sprite definido 
var lista_vidas = []
export 	(PackedScene) var spr_vidas

func crear_vidas():
	for i in vidas_player:
		var nueva_vida = spr_vidas.instance()
		#VE AL ARBOL DE LA ESENA
		#DIME LOS GRUPOS QUE SE ENCUENTRAN
		#SI ESTA GUI 	
		#0 POR QUE HAY SOLO UN GUI 
		#AGREGA UN HIJO 
		#NUEVA VIDA 
		get_tree().get_nodes_in_group("GUI")[0].add_child(nueva_vida)
		nueva_vida.global_position.x += offset_vida * i
		lista_vidas.append(nueva_vida)
		
func quitar_vida():
	#quitar un objeto de la lista de vidas
	#no vuelve a crear otra vida

	#elimina la vida de la pantalla 
	vidas_player -= 1
	lista_vidas[vidas_player].queue_free()
	
	
	
func agregar_vida():
	vidas_player += 1
	var nueva_vida = spr_vidas.instance()
	get_tree().get_nodes_in_group("GUI")[0].add_child(nueva_vida)
	nueva_vida.global_position.x += offset_vida * (vidas_player - 1)
	lista_vidas[vidas_player-1].append(nueva_vida)
	pass
#vidas jugador ------------------------------------------------------------------------------------------------vidas

func _ready():
	#----------vidas-------------
	crear_vidas()
	set_process(true)
	set_process_input(true)
	#NO VER DRAW PAUSA
	label.visible = false
		
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().reload_current_scene()
	
		
func _input(event):
	#PAUSA 
	if Input.is_action_just_pressed("pausa_mia"):
		if !get_tree().is_paused():
			get_tree().set_pause(true)
			#SPRITE DE PAUSA 
			label.visible = true
			pass
		elif get_tree().is_paused() == true:
			get_tree().set_pause(false)
			#SPRITE DE PAUSA
			label.visible = false
			pass
	#prueva de muerte 
	if Input.is_action_pressed("morir"):
		quitar_vida()

