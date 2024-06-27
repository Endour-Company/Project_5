extends Control

var username : String
var time : String
var totalMoney : String
var happiness : String
var health : String
var itemLevel
var stars = 0
@onready var SFX = $SFX
signal close_signal

func _ready():
	SFX.set_volume_db(GameAudio.get_volume_sfx())
	
	# Set indicators
	set_username()
	set_time()
	set_money()
	set_happiness()
	set_health()
	
	# Set fasilitas tiap sektor
	set_sawah()
	set_hutan()
	set_pemukiman()
	set_pusat_desa()
	
	# Calculate stars
	calculate_stars()


# Setter method for indicators
func set_username():
	var usernameLabel = $GridContainer/Indicator_Username/TextureRect/HBoxContainer/Username
	usernameLabel.set_text(username)
	
func set_time():
	var timeLabel = $GridContainer/Indicator_Time/TextureRect/HBoxContainer/Time
	timeLabel.set_text(time)
	
func set_money():
	var formattedMoney = totalMoney
	var moneyLabel = $GridContainer/Indicator_Money/TextureRect/HBoxContainer/TotalMoney
	moneyLabel.set_text(formattedMoney)
	
func set_happiness():
	var happiness = happiness
	var happinessLabel = $GridContainer/Indicator_Happy_Health/Indicator_Happy/TextureRect/HBoxContainer/Percentage_Happy
	happinessLabel.set_text(happiness)
	
func set_health():
	var health = health
	var healthLabel = $GridContainer/Indicator_Happy_Health/CenterContainer2/TextureRect/HBoxContainer/Percentage_Health
	healthLabel.set_text(health)


# Methods for sektor sawah
func set_sawah():
	# Labels
	var alatPertanianLabel = $GridContainer/Sektor_Sawah/TextureRect/VBoxContainer/Fasilitas/AlatPertanian/Level
	var jalanSawahLabel = $GridContainer/Sektor_Sawah/TextureRect/VBoxContainer/Fasilitas/JalanSawah/Level
	var lampuJalanLabel = $GridContainer/Sektor_Sawah/TextureRect/VBoxContainer/Fasilitas/LampuJalanSawah/Count
	
	# Get level and count of facilities
	var alatPertanianLevel = get_item_level("Alat Pertanian")
	var jalanSawahLevel = get_item_level("Jalan Sawah")
	var lampuJalanCount = get_item_count("Lampu Jalan Sawah")
	
	# Set label and image of alat pertanian
	set_label_level(alatPertanianLabel, alatPertanianLevel)
	set_alat_pertanian_texture(alatPertanianLevel)
	
	# Set label and image of jalan sawah
	set_label_level(jalanSawahLabel, jalanSawahLevel)
	set_jalan_sawah_texture(jalanSawahLevel)
	
	# Set label of lampu jalan
	set_label_count(lampuJalanLabel, lampuJalanCount)

func set_alat_pertanian_texture(level : int):
	var alatPertanianTexture = $GridContainer/Sektor_Sawah/TextureRect/VBoxContainer/Fasilitas/AlatPertanian/ItemCircle/MarginContainer/ItemImg
	match level:
		1:
			alatPertanianTexture.set_texture(preload("res://Game/Ricefield/Assets/item_up_pembajak_sawah/pembajak_sawah_lv1.png"))
		2:
			alatPertanianTexture.set_texture(preload("res://Game/Ricefield/Assets/item_up_pembajak_sawah/pembajak_sawah_lv2.png"))
		3:
			alatPertanianTexture.set_texture(preload("res://Game/Ricefield/Assets/item_up_pembajak_sawah/pembajak_sawah_lv3.png"))
	
func set_jalan_sawah_texture(level: int):
	var jalanSawahTexture = $GridContainer/Sektor_Sawah/TextureRect/VBoxContainer/Fasilitas/JalanSawah/ItemCircle/MarginContainer/ItemImg
	match level:
		1:
			jalanSawahTexture.set_texture(preload("res://Game/Ricefield/Assets/item_up_jalan/jalan_lv1.png"))
		2:
			jalanSawahTexture.set_texture(preload("res://Game/Ricefield/Assets/item_up_jalan/jalan_lv2.png"))
		3:
			jalanSawahTexture.set_texture(preload("res://Game/Ricefield/Assets/item_up_jalan/jalan_lv3.png"))


# Methods for sektor hutan
func set_hutan():
	# Labels
	var cendanaLabel = $GridContainer/Sektor_Hutan/TextureRect/VBoxContainer/Fasilitas/Cendana/Count
	var jatiLabel = $GridContainer/Sektor_Hutan/TextureRect/VBoxContainer/Fasilitas/Jati/Count
	var mahoniLabel = $GridContainer/Sektor_Hutan/TextureRect/VBoxContainer/Fasilitas/Mahoni/Count
	
	# Get count of trees
	var cendanaCount = get_item_count("Cendana")
	var jatiCount = get_item_count("Jati")
	var mahoniCount = get_item_count("Mahoni")
	
	# Set labels
	set_label_count(cendanaLabel, cendanaCount)
	set_label_count(jatiLabel, jatiCount)
	set_label_count(mahoniLabel, mahoniCount)


# Methods for sektor pemukiman
func set_pemukiman():
	# Labels
	var toiletLabel = $GridContainer/Sektor_Pemukiman/TextureRect/VBoxContainer/Fasilitas/ToiletUmum/Count
	var septicLabel = $GridContainer/Sektor_Pemukiman/TextureRect/VBoxContainer/Fasilitas/SepticTank/Count
	var towerLabel = $GridContainer/Sektor_Pemukiman/TextureRect/VBoxContainer/Fasilitas/TowerInternet/Count
	var jalanLabel = $GridContainer/Sektor_Pemukiman/TextureRect/VBoxContainer/Fasilitas/JalanPemukiman/Level
	var lampuLabel = $GridContainer/Sektor_Pemukiman/TextureRect/VBoxContainer/Fasilitas/LampuJalanPemukiman/Count
	
	# Get level and count of facilities
	var toiletCount = get_item_count("Toilet Umum")
	var septicCount = get_item_count("Septic Tank")
	var towerCount = get_item_count("Tower Internet")
	var jalanLevel = get_item_level("Jalan Pemukiman")
	var lampuCount = get_item_count("Lampu Jalan Pemukiman")
	
	# Set labels and images of jalan pemukiman
	set_label_level(jalanLabel, jalanLevel)
	set_jalan_pemukiman_texture(jalanLevel)
	
	# Set other labels
	set_label_count(toiletLabel, toiletCount)
	set_label_count(septicLabel, septicCount)
	set_label_count(towerLabel, towerCount)
	set_label_count(lampuLabel, lampuCount)
	
func set_jalan_pemukiman_texture(level: int):
	var jalanPemukimanTexture = $GridContainer/Sektor_Pemukiman/TextureRect/VBoxContainer/Fasilitas/JalanPemukiman/ItemCircle/MarginContainer/ItemImg
	match level:
		1:
			jalanPemukimanTexture.set_texture(preload("res://Game/Area_pemukiman/Assets/item_up_jalan/jalan_lv1.png"))
		2:
			jalanPemukimanTexture.set_texture(preload("res://Game/Area_pemukiman/Assets/item_up_jalan/jalan_lv2.png"))
		3:
			jalanPemukimanTexture.set_texture(preload("res://Game/Area_pemukiman/Assets/item_up_jalan/jalan_lv3.png"))


# Methods for pusat desa
func set_pusat_desa():
	# Labels
	var jalanLabel = $GridContainer/Sektor_Pusat/TextureRect/VBoxContainer/Fasilitas/JalanPusat/Level
	var pasarLabel = $GridContainer/Sektor_Pusat/TextureRect/VBoxContainer/Fasilitas/Pasar/Level
	var lapanganLabel = $GridContainer/Sektor_Pusat/TextureRect/VBoxContainer/Fasilitas/Lapangan/Level
	var puskesmasLabel = $GridContainer/Sektor_Pusat/TextureRect/VBoxContainer/Fasilitas/Puskesmas/Level
	var baldesLabel = $GridContainer/Sektor_Pusat/TextureRect/VBoxContainer/Fasilitas/BalaiDesa/Level
	var lampuLabel = $GridContainer/Sektor_Pusat/TextureRect/VBoxContainer/Fasilitas/LampuJalanPusat/Count
	
	# Get level and count of facilities
	var jalanLevel = get_item_level("Jalan Pusat Desa")
	var pasarLevel = get_item_level("Pasar")
	var lapanganLevel = get_item_level("Tanah Lapang")
	var puskesmasLevel = get_item_level("Puskesmas")
	var baldesLevel = get_item_level("Balai Desa")
	var lampuCount = get_item_count("Lampu Jalan Pusat Desa")
	
	# Set label and image of jalan pusat desa
	set_label_level(jalanLabel, jalanLevel)
	set_jalan_pusat_texture(jalanLevel)
	
	# Set label and image of pasar
	set_label_level(pasarLabel, pasarLevel)
	set_pasar_texture(pasarLevel)
	
	# Set label and image of puskesmas
	set_label_level(puskesmasLabel, puskesmasLevel)
	set_puskesmas_texture(puskesmasLevel)
	
	# Set label and image of baldes
	set_label_level(baldesLabel, baldesLevel)
	set_baldes_texture(baldesLevel)
	
	# Set other labels
	set_label_level(lapanganLabel, lapanganLevel)
	set_label_count(lampuLabel, lampuCount)

func set_jalan_pusat_texture(level: int):
	var jalanPusatTexture = $GridContainer/Sektor_Pusat/TextureRect/VBoxContainer/Fasilitas/JalanPusat/ItemCircle/MarginContainer/ItemImg
	match level:
		1:
			jalanPusatTexture.set_texture(preload("res://Game/Area_pusat_desa/Assets/item_up_jalan/jalan_lv1.png"))
		2:
			jalanPusatTexture.set_texture(preload("res://Game/Area_pusat_desa/Assets/item_up_jalan/jalan_lv2.png"))
		3:
			jalanPusatTexture.set_texture(preload("res://Game/Area_pusat_desa/Assets/item_up_jalan/jalan_lv3.png"))

func set_pasar_texture(level: int):
	var pasarTexture = $GridContainer/Sektor_Pusat/TextureRect/VBoxContainer/Fasilitas/Pasar/ItemCircle/MarginContainer/ItemImg
	match level:
		1:
			pasarTexture.set_texture(preload("res://Game/Area_pusat_desa/Assets/item_up_pasar/pasar_lv1.png"))
		2:
			pasarTexture.set_texture(preload("res://Game/Area_pusat_desa/Assets/item_up_pasar/pasar_lv2.png"))
		3:
			pasarTexture.set_texture(preload("res://Game/Area_pusat_desa/Assets/item_up_pasar/pasar_lv3.png"))

func set_puskesmas_texture(level: int):
	var puskesmasTexture = $GridContainer/Sektor_Pusat/TextureRect/VBoxContainer/Fasilitas/Puskesmas/ItemCircle/MarginContainer/ItemImg
	match level:
		1:
			puskesmasTexture.set_texture(preload("res://Game/Area_pusat_desa/Assets/item_up_puskesmas/puskesmas_lv1.png"))
		2:
			puskesmasTexture.set_texture(preload("res://Game/Area_pusat_desa/Assets/item_up_puskesmas/puskesmas_lv2.png"))

func set_baldes_texture(level: int):
	var baldesTexture = $GridContainer/Sektor_Pusat/TextureRect/VBoxContainer/Fasilitas/BalaiDesa/ItemCircle/MarginContainer/ItemImg
	match level:
		1:
			baldesTexture.set_texture(preload("res://Game/Area_pusat_desa/Assets/item_up_balai_desa/balai_desa_lv1.png"))
		2:
			baldesTexture.set_texture(preload("res://Game/Area_pusat_desa/Assets/item_up_balai_desa/balai_desa_lv2.png"))


# General methods
func get_item_level(name: String):
	var item = Utils.find_item_in_array_with_key(itemLevel, "name", name)
	return item["level"]
	
func get_item_max_level(name: String, area: String):
	var items
	match area:
		"Sawah":
			items = Utils.parse_json_file_by_filepath("res://Data/Items_ricefields.json")
		"Hutan":
			items = Utils.parse_json_file_by_filepath("res://Data/Items_hutan.json")
		"Pemukiman":
			items = Utils.parse_json_file_by_filepath("res://Data/Items_pemukiman.json")
		"Pusat Desa":
			items = Utils.parse_json_file_by_filepath("res://Data/items_pusat_desa.json")
			
	var item = Utils.find_item_in_array_with_key(items, "name", name)
	return len(item["levels"])
	
func get_item_count(name: String):
	var item = Utils.find_item_in_array_with_key(itemLevel, "name", name)
	return item["count"]
	
func get_item_max_count(name: String, area: String):
	var items
	match area:
		"Sawah":
			items = Utils.parse_json_file_by_filepath("res://Data/Items_ricefields.json")
		"Hutan":
			items = Utils.parse_json_file_by_filepath("res://Data/Items_hutan.json")
		"Pemukiman":
			items = Utils.parse_json_file_by_filepath("res://Data/Items_pemukiman.json")
		"Pusat Desa":
			items = Utils.parse_json_file_by_filepath("res://Data/items_pusat_desa.json")
			
	var item = Utils.find_item_in_array_with_key(items, "name", name)
	return item["max_owned"]

func calculate_stars():
	# Indicators
	var happiness = Variables.get_kesejehtaraan_percentage() / 4
	var health = Variables.get_kesehatan_percentage() / 4
	stars += happiness + health
	
	var sector_score = 0
	
	# Sektor sawah
	var levelAlat = get_item_level("Alat Pertanian") / get_item_max_level("Alat Pertanian", "Sawah")
	var levelJalanSawah = get_item_level("Jalan Sawah") / get_item_max_level("Jalan Sawah", "Sawah")
	var countLampuSawah = get_item_count("Lampu Jalan Sawah") / get_item_max_count("Lampu Jalan Sawah", "Sawah")
	sector_score += (levelAlat + levelJalanSawah + countLampuSawah) / 3
	
	# Sektor pemukiman
	var levelJalanPemukiman = get_item_level("Jalan Pemukiman") / get_item_max_level("Jalan Pemukiman", "Pemukiman")
	var countToilet = get_item_count("Toilet Umum") / get_item_max_count("Toilet Umum", "Pemukiman")
	var countTower = get_item_count("Tower Internet") / get_item_max_count("Tower Internet", "Pemukiman")
	var countSeptic = get_item_count("Septic Tank") / get_item_max_count("Septic Tank", "Pemukiman")
	var countLampuPemukiman = get_item_count("Lampu Jalan Pemukiman") / get_item_max_count("Lampu Jalan Pemukiman", "Pemukiman")
	sector_score += (levelJalanPemukiman + countLampuPemukiman + countSeptic + countToilet + countTower) / 5
	
	# Sektor pusat desa
	var levelJalanPusat = get_item_level("Jalan Pusat Desa") / get_item_max_level("Jalan Pusat Desa", "Pusat Desa")
	var levelBalai = get_item_level("Balai Desa") / get_item_max_level("Balai Desa", "Pusat Desa")
	var levelPuskesmas = get_item_level("Puskesmas") / get_item_max_level("Puskesmas", "Pusat Desa")
	var levelLapangan = get_item_level("Tanah Lapang") / get_item_max_level("Tanah Lapang", "Pusat Desa")
	var levelPasar = get_item_level("Pasar") / get_item_max_level("Pasar", "Pusat Desa")
	var countLampuPusat = get_item_count("Lampu Jalan Pusat Desa") / get_item_max_count("Lampu Jalan Pusat Desa", "Pusat Desa")
	sector_score += (levelJalanPusat + levelBalai + levelPuskesmas + levelLapangan + levelPasar + countLampuPusat) / 6
	
	stars += (sector_score * 50) / 3
	
	# Floor value of stars
	stars = round((stars / 10)) * 10
	
	# Set stars
	$Stars.set_value_no_signal(stars)

func set_label_level(label: Label, level: int):
	label.set_text("Level " + str(level))
	
func set_label_count(label: Label, count: int):
	label.set_text("Punya " + str(count))
	
func _on_keluar_button_pressed():
	GameAudio.play(SFX, GameAudio.SFX_Gameplay_Click)
	close_signal.emit()

func _on_keluar_button_mouse_entered():
	GameAudio.play(SFX, GameAudio.SFX_Gameplay_Hover)
