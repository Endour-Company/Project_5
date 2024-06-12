extends Node2D


# Called when the node enters the scene tree for the first time.
var textureSungaiKotor  = load("")
var textureSungaiNormal = load("")
var textureSungaiBerkilau = load("")

@onready var TEXTURE_NODE = $TextureRect

enum STATUSES_SUNGAI {
	KOTOR,
	NORMAL,
	BERKILAU
} 


var DATA_STATUS_SUNGAI = []


var STATUS_SUNGAI = STATUSES_SUNGAI.KOTOR

func _ready():
	DATA_STATUS_SUNGAI = [
		{
			"status" : STATUSES_SUNGAI.KOTOR,
			"threshold_min" : 0,
			"threshold_max" : 0.5,
			"texture" : textureSungaiKotor
		},
		{
			"status" : STATUSES_SUNGAI.NORMAL,
			"threshold_min" : 0.5,
			"threshold_max" : 0.8,
			"texture" : textureSungaiNormal
		},
		{
			"status" : STATUSES_SUNGAI.BERKILAU,
			"threshold_min" : 0.8,
			"threshold_max" : 1.01,
			"texture" : textureSungaiBerkilau
		},
	]
	
	watch_kualitas_air()
	change_texture_of_sungai()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	watch_kualitas_air()
	var statusSungai = STATUS_SUNGAI
	if(statusSungai != STATUS_SUNGAI) :
		change_texture_of_sungai()


func watch_kualitas_air() :
	var varKualitasAir = Variables.VAR_KUALITAS_AIR
	
	for statusData in DATA_STATUS_SUNGAI:
		if varKualitasAir >= statusData["threshold_min"] and varKualitasAir < statusData["threshold_max"]:
			STATUS_SUNGAI = statusData["status"]
			break


func change_texture_of_sungai():
	var dataOfCurentStatusSungai = Utils.find_item_in_array_with_key(DATA_STATUS_SUNGAI, "status", STATUS_SUNGAI)
	var texture = dataOfCurentStatusSungai["texture"]
	TEXTURE_NODE.set_texture(texture)
