<div align="center">
    <h2>Alwie Attar Elfandra</h2>
    <h2>2306241726</h2>
</div>

<div align="center">
    <h1>Tutorial 4</h1>
</div>

### Fitur Level 2

1. **Tileset berbeda** — Menggunakan `spritesheet_gr_snow.png` dan `spritesheet_gr_stone.png` sebagai tile map, memberikan nuansa lingkungan salju yang berbeda dari level pertama.

2. **Rintangan baru: Falling Saw** — Objek gergaji (saw blade) yang berjatuhan secara periodik dari spawner di atas map. Saw blade ini **berputar saat jatuh** (polishing) dan akan hilang ketika mengenai tanah.

3. **Moving Platform** — Platform yang bergerak secara periodik dari posisi awal ke posisi akhir.

### Proses Implementasi

#### 1. Membuat Obstacle Baru (`falling_saw.gd` & `falling_saw.tscn`)
- Membuat script `falling_saw.gd` yang mirip dengan `falling_fish.gd` tetapi dengan tambahan fitur rotasi otomatis (`rotation_speed`) agar saw blade terlihat berputar saat jatuh.
- Menggunakan `class_name FallingSaw` agar dapat dideteksi oleh player melalui keyword `is`.
- Menggunakan `contact_monitor` dan signal `body_entered` untuk mendeteksi tabrakan dengan tanah dan menghapus diri sendiri (`queue_free()`).
- Scene menggunakan `RigidBody2D` dengan `CircleShape2D` (bentuk bulat sesuai saw blade) dan sprite `saw.png` dari Kenney Platformer Pack.
- `collision_layer = 2` dan `collision_mask = 2` agar konsisten dengan sistem collision yang sudah ada.

#### 2. Membuat Level 2 Scene (`Level2.tscn`)
- Menggunakan `TileSet` baru dengan sumber atlas dari `spritesheet_gr_snow.png` (sebagai permukaan atas/snow) dan `spritesheet_gr_stone.png` (sebagai dekorasi bawah tanah).
- Menambahkan `MovingPlatform` ke dalam level.
- Layout platform dirancang untuk memaksa pemain melakukan lompatan-lompatan presisi.
- Menambahkan `ChangeSceneArea` di bagian bawah map sebagai death pit yang mengarahkan ke `LoseScreen`.
- Menambahkan area kemenangan (Goal) dengan `ChangeSceneArea` yang mengarahkan ke `WinScreen`.
- Spawner menggunakan `spawner.gd` yang sudah ada, tetapi dengan obstacle diubah ke `falling_saw.tscn`.

#### 3. Mengupdate Player (`player.gd`)
- Menambahkan deteksi `FallingSaw` pada fungsi `_on_hit_box_body_entered`:
  ```gdscript
  if body is FallingFish or body is FallingSaw:
      get_tree().change_scene_to_file("res://scenes/LoseScreen.tscn")
  ```

<div align="center">
    <h1>Tutorial 6</h1>
</div>

### Implementasi Sistem Life & UI Counter

1. **Membuat Scene UI Life Counter (`life_counter.tscn`)**
   - Menggunakan `MarginContainer`, `VBoxContainer`, dan `Label` untuk menampilkan sisa nyawa (lives) di bagian pojok kanan atas layar (`CanvasLayer`).
   - Menerapkan custom font `Perfect DOS VGA 437 Win.ttf` agar cocok dengan estetika *game* retro.

2. **Menambahkan Mekanik Nyawa pada Player (`player.gd`)**
   - Memberikan properti `life_count` sebesar 3.
   - Menambahkan custom *signal* `life_changed(new_life: int)` yang di-emit saat awal game berjalan, juga ketika pemain terkena rintangan jatuh (`FallingFish` atau `FallingSaw`).
   - Logika kematian pemain (pindah ke `LoseScreen`) baru dipicu saat nyawa habis menebus 0 (dicek saat berada di `life_count == 1`).

3. **Menghubungkan Player dengan UI Life Counter (`level_base.gd`)**
   - Memastikan semua Level (misal `Level1.tscn` dan `Level2.tscn`) terhubung dengan sebuah *base script*.
   - Mengambil referensi dari node `Player` dan mengakses UI Label pada `CanvasLayer`.
   - Secara dinamis (via kode *script*) menghubungkan *signal* `life_changed` dari `Player` milik *level* tersebut ke fungsi khusus `update_life_counter`.
   - Hal ini memastikan sisa nyawa otomatis ter-*update* (menjadi string "Live : X") pada layar UI setiap kali *signal* berkurangnya nyawa terpanggil, menghindari perubahan secara manual dan berulang pada setiap Level.