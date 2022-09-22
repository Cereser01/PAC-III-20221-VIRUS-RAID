extends Node

var node_creation_parent = null
var player = null
var playertype = "virus"
var enemy_count = 0
var immunity = 0.0
var infection = 0.0
var difficulty = 1.0
var health
var linfocitobvivo = false
var mira = "mouse"
var shoot_backwards = false
var language = "ptbr"
var movimentacao = "teclado"
var level = 1
var musicvolume = 1.00
var effectsvolume = 1.00
var screensize_vert = 768
var screensize_horiz = 1366

func instance_node(node, location, parent):
		var node_instance = node.instance()
		parent.add_child(node_instance)
		node_instance.global_position = location
		return node_instance


func increase_infection(amount):
	infection += (amount/difficulty)

func reset_globals():
	infection = 0.0
	immunity = 0.0
	enemy_count = 0
	playertype = "virus"
	linfocitobvivo = false
	player = null
	node_creation_parent = null
	shoot_backwards = false



func mouse_shoot(node):
	return (node.velocity.rotated(node.rotation) * node.speed)
