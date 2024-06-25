extends Node


@export var MONEY : int = 50000000000

# AREA : ALL (Range 0-1)
# Global Atribute
var VAR_KUALITAS_AIR = 0 # Range  : 0-1
var VAR_PENDAPATAN = 0 # Range  : 0-1
var VAR_KESEHATAN_MASYARAKAT = 0 # Range  : 0-1
var VAR_KESEJAHTERAAN_MASYARAKAT = 0 # Range  : 0-1

#  ====== AREA : SAWAH
var KUALITAS_PADI = 1 # Range  : 0-1
var KUANTITAS_PADI = 1 # Range : 0-1
var HAMA_COUNT = 1 # Range : 0-1

# Item Upgraded
var PESTISIDA_VOLUME = 1 # Range : 1-3
# Support atribute
var GROWTH_SPEED =  1 # Range  : 0-1
var MAX_LEVEL_OF_JALAN_SAWAH = 3
var MAX_COUNT_OF_LAMPU_JALAN_SAWAH = 3
#  ====== END OF AREA : SAWAH


#  ====== AREA : HUTAN
var DAYA_SERAP_POHON = 1
# Support Atribute
var LOGGING_VOLUME = 1 # Range : 0-5
var MAX_COUNT_POHON = 11 
var COUNT_POHON = 1

# ====== END OF AREA : HUTAN


#  ====== AREA : PUSAT DESA
var DAYA_BELI = 1 # Range : 11

# Support variable
var MAX_LEVEL_OF_PASAR = 3
var MAX_LEVEL_OF_JALAN_PUSAT_DESA = 3
var MAX_LEVEL_OF_TANAH_LAPANG = 3
var MAX_LEVEL_OF_PUSKESMAS = 2
var MAX_LEVEL_OF_BALAI_DESA = 2
var MAX_COUNT_OF_LAMPU_JALAN_PUSAT_DESA = 6
# ====== END OF AREA : PUSAT DESA

#  ====== AREA : PEMUKIMAN
var SANTIATION = 1 # Range : 0 - 1 

# Support Atribute
var MAX_LEVEL_OF_JALAN_PEMUKIMAN = 3
var MAX_COUNT_OF_TOWER_INTERNET = 2
var MAX_COUNT_OF_SEPTIC_TANK = 3 
var MAX_COUNT_OF_TOILET = 6
var MAX_COUNT_OF_LAMPU_JALAN_PEMUKIMAN = 5

#  ====== END OF AREA : PEMUKIMAN

signal money_changed

func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	watch_kualtas_air()
	watch_kuantitas_padi()
	watch_pendapatan()
	watch_kesehatan_masyarakat()
	watch_kesejahteraan_masyarakat()
	
func set_money(action : String, value : int):
	match action : 
		"min" :
			MONEY -= value
		"plus" :
			MONEY += value
	emit_signal("money_changed")

func set_logging_volume(value : int):
	LOGGING_VOLUME = value



# ==== FUNCTION OF GLOBAL ATRIBUTE ====
func watch_kualtas_air():
	var kualitasAir = 0
	
	watch_sanitation()
	watch_daya_serap_pohon()
	watch_daya_beli()
		
	var normalizedLevelOfPasar : float = (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Pasar"))["level"] / float(MAX_LEVEL_OF_PASAR)
	var normalizedPestisidaVolume : float = PESTISIDA_VOLUME / 3.0
	kualitasAir = (SANTIATION * 0.5) + (DAYA_SERAP_POHON * 0.4) + (normalizedLevelOfPasar * 0.1) - (normalizedPestisidaVolume * 0.1) - (0.1 * DAYA_BELI) 
	if kualitasAir < 0 :
		kualitasAir = 0
	
	VAR_KUALITAS_AIR = kualitasAir
	

func watch_pendapatan() :
	var pendapatan = 0
	var normalizedLevelOfTanahLapang: float = (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Tanah Lapang"))["level"] / float(MAX_LEVEL_OF_TANAH_LAPANG)
	var normalizedCountOfTowerInternet : float =  (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Tower Internet"))["count"] / float(MAX_COUNT_OF_TOWER_INTERNET)
	var normalizedLevelOfJalanPemukiman: float = (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Jalan Pemukiman"))["level"] / float(MAX_LEVEL_OF_JALAN_PEMUKIMAN)
	pendapatan = 0.5 + (DAYA_BELI * 0.3) + (normalizedLevelOfTanahLapang * 0.1) + (normalizedLevelOfJalanPemukiman * 0.1) - (normalizedCountOfTowerInternet * 0.1)
	
	VAR_PENDAPATAN = pendapatan
	
func watch_kesehatan_masyarakat() :
	var kesehatanMasyarakat = 0
	var normalizedLevelOfPuskesmas : float =  (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Puskesmas"))["level"] / float(MAX_LEVEL_OF_PUSKESMAS)
	
	kesehatanMasyarakat = (0.2) + (normalizedLevelOfPuskesmas * 0.2) + (VAR_KUALITAS_AIR * 0.4) + (KUALITAS_PADI * 0.2) 
	
	VAR_KESEHATAN_MASYARAKAT = kesehatanMasyarakat
	
func watch_kesejahteraan_masyarakat() :
	var kesejahteraanMasyarakat = 0
	
	# Area : Pemukiman
	var normalizedCountOfTowerInternet : float =  (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Tower Internet"))["count"] / float(MAX_COUNT_OF_TOWER_INTERNET)
	var normalizedLevelOfJalanPemukiman: float = (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Jalan Pemukiman"))["level"] / float(MAX_LEVEL_OF_JALAN_PEMUKIMAN)
	var normalizedCountOfLampuJalanPemukiman : float =  (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Lampu Jalan Pemukiman"))["count"] / float(MAX_COUNT_OF_LAMPU_JALAN_PEMUKIMAN)
	
	# Area : Sawah
	var normalizedCountOfLampuJalanSawah : float =  (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Lampu Jalan Sawah"))["count"] / float(MAX_COUNT_OF_LAMPU_JALAN_SAWAH)
	
	# Area : Pusat Desa
	var normalizedLevelOfJalanPusatDesa : float = (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Jalan Pusat Desa"))["level"] / float(MAX_LEVEL_OF_JALAN_PUSAT_DESA)
	var normalizedLevelOfBalaiDesa : float = (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Balai Desa"))["level"] / float(MAX_LEVEL_OF_BALAI_DESA)
	var normalizedLevelOfTanahLapang: float = (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Tanah Lapang"))["level"] / float(MAX_LEVEL_OF_TANAH_LAPANG)
	var normalizedCountOfLampuJalanPusatDesa : float = (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Lampu Jalan Pusat Desa"))["count"] / float(MAX_COUNT_OF_LAMPU_JALAN_PUSAT_DESA)
	
	kesejahteraanMasyarakat = (normalizedCountOfTowerInternet * 0.1) + (normalizedCountOfLampuJalanPemukiman * 0.1) + (normalizedCountOfLampuJalanPemukiman * 0.1) + (KUANTITAS_PADI * 0.1) + (normalizedCountOfLampuJalanSawah * 0.1) + (normalizedCountOfLampuJalanPusatDesa * 0.1) + (normalizedLevelOfBalaiDesa * 0.1) + (normalizedLevelOfTanahLapang * 0.1) + (normalizedCountOfLampuJalanPusatDesa * 0.2)
	
	VAR_KESEJAHTERAAN_MASYARAKAT = kesejahteraanMasyarakat
# ==== END OF FUNCTION GLOBAL ATRIBUTE ====

# FUNCTION OF AREA : SAWAH
func watch_kualitas_padi():
	var kualitasPadi = 0
	if VAR_KUALITAS_AIR == 0:
		kualitasPadi = 0.5

	kualitasPadi =  0.5 * VAR_KUALITAS_AIR + 0.5
	KUALITAS_PADI = kualitasPadi

func watch_kuantitas_padi():
	
	# Relation to KUALITAS_AIR
	var kuantitasPadi = 0
	if VAR_KUALITAS_AIR == 0:
		kuantitasPadi = 0.5

	
	# Relationn to Level Of Jalan Sawah
	var normalizedLevelOfJalanSawah = (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Jalan Sawah")["level"]) / 3 # Divide by max level of jalan sawah
	
	kuantitasPadi = 0.5 + (0.3 * VAR_KUALITAS_AIR) + (0.2 * normalizedLevelOfJalanSawah)
	
	
	# Relation to PESTISIDA_VOLUME
	var normalizedPestisidaVolume : float = PESTISIDA_VOLUME / 3.0 #Divide by max_pestida_volume
	kuantitasPadi -= (1-PESTISIDA_VOLUME) / 5.0
	
	KUANTITAS_PADI = kuantitasPadi
	
# END OF FUNCTION AREA : SAWAH


# FUNCTION OF AREA : PEMUKIMAN
func watch_sanitation():
	var sanitation : float = 0
	
	var normalizedCountOfSeptictank : float  = (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Septic Tank"))["count"] / float(MAX_COUNT_OF_SEPTIC_TANK)
	var normalizedCountOfToilet: float  = (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Toilet Umum"))["count"] / float(MAX_COUNT_OF_TOILET)
	
	for variable in [normalizedCountOfSeptictank,normalizedCountOfToilet] :
		sanitation += variable/2.0
	
	SANTIATION = sanitation
	
# END OF FUNCTION AREA : PEMUKIMAN


# FUNCTION OF AREA : HUTAN
func watch_daya_serap_pohon() :
	var dayaSerapPohon = 0
	var normalizedCountPohon : float = COUNT_POHON / float(MAX_COUNT_POHON)
	DAYA_SERAP_POHON = normalizedCountPohon


func watch_growth_speed() :
	var growthSpeed = 0
	if VAR_KUALITAS_AIR == 0:
		growthSpeed = 0.5

	growthSpeed =  0.5 * VAR_KUALITAS_AIR + 0.5
	GROWTH_SPEED = growthSpeed


# END OF FUNCTION AREA : HUTAN


# FUNCTION OF AREA : PUSAT DESA
func watch_daya_beli() :
	var dayaBeli = 0
	var normalizedLevelOfJalanDesa : float = (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Jalan Pusat Desa"))["level"] / float(MAX_LEVEL_OF_JALAN_PUSAT_DESA)
	
	dayaBeli = (normalizedLevelOfJalanDesa * 0.8) + (KUANTITAS_PADI * 0.2)
	DAYA_BELI = dayaBeli
	
# END OF FUNCTION AREA : PUSAT DESA

func get_kesejehtaraan_percentage():
	var happiness = float((VAR_KESEJAHTERAAN_MASYARAKAT / 1) * 100)
	return happiness
	
func get_kesehatan_percentage():
	var health = float((VAR_KESEHATAN_MASYARAKAT / 1) * 100)
	return health
