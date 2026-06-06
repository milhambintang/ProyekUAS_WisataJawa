import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wisata_jawa/models/wisata.dart';
import 'package:wisata_jawa/services/firestore_service.dart';

class AddWisataScreen extends StatefulWidget {
  final Wisata? wisata; // null = tambah baru, non-null = edit

  const AddWisataScreen({super.key, this.wisata}); // Parameter opsional untuk edit wisata

  @override
  State<AddWisataScreen> createState() => _AddWisataScreenState(); // Membuat state untuk AddWisataScreen
}

class _AddWisataScreenState extends State<AddWisataScreen> {  // State untuk AddWisataScreen
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestoreService = FirestoreService();
  final String? _userId = FirebaseAuth.instance.currentUser?.uid;

  late TextEditingController _namaController; // Controller untuk input nama wisata
  late TextEditingController _deskripsiController;
  late TextEditingController _kotaController;

  String _selectedProvinsi = FirestoreService.provinsiList.first; // Default provinsi pertama dari daftar
  double _rating = 4.0;
  String _base64Image = '';
  Uint8List? _imagePreview;
  bool _isLoading = false;

  bool get _isEditing => widget.wisata != null; // Menentukan apakah sedang dalam mode edit atau tambah baru

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.wisata?.nama ?? '');
    _deskripsiController =
        TextEditingController(text: widget.wisata?.deskripsi ?? '');
    _kotaController = TextEditingController(text: widget.wisata?.kota ?? '');

    if (_isEditing) {
      _selectedProvinsi = widget.wisata!.provinsi;
      _rating = widget.wisata!.rating;
      _base64Image = widget.wisata!.gambar;
      if (_base64Image.isNotEmpty) {
        try {
          _imagePreview = base64Decode(_base64Image);
        } catch (_) {}
      }
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _deskripsiController.dispose();
    _kotaController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 600,
      imageQuality: 60, // Kompresi untuk meminimalkan ukuran Base64
    );

    if (picked == null) return;

    final bytes = await picked.readAsBytes();

    // Check ukuran (max 700KB setelah kompresi, ~950KB Base64)
    if (bytes.length > 700 * 1024) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Gambar terlalu besar. Maksimal 700KB setelah kompresi.'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    setState(() {
      _imagePreview = bytes;
      _base64Image = base64Encode(bytes);
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_base64Image.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih gambar wisata'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final wisata = Wisata(
        id: _isEditing ? widget.wisata!.id : '',
        nama: _namaController.text.trim(),
        deskripsi: _deskripsiController.text.trim(),
        provinsi: _selectedProvinsi,
        kota: _kotaController.text.trim(),
        gambar: _base64Image,
        rating: _rating,
        createdAt: _isEditing ? widget.wisata!.createdAt : DateTime.now(),
        createdBy: _userId ?? '',
      );

      if (_isEditing) {
        await _firestoreService.updateWisata(wisata);
      } else {
        await _firestoreService.addWisata(wisata);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing
                ? 'Wisata berhasil diperbarui'
                : 'Wisata berhasil ditambahkan'),
            backgroundColor: const Color(0xFF2E7D32),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
      prefixIcon: Icon(icon, color: const Color(0xFF388E3C), size: 20),
      filled: true,
      fillColor: const Color(0xFFF5F7F5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF43A047), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE53935), width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE53935), width: 1.5),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        title: Text(
          _isEditing ? 'Edit Wisata' : 'Tambah Wisata',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image picker
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: _imagePreview != null
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.memory(
                              _imagePreview!,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color:
                                      Colors.black.withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.edit,
                                        color: Colors.white, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      'Ganti',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_photo_alternate_outlined,
                                size: 48, color: Colors.grey.shade400),
                            const SizedBox(height: 8),
                            Text(
                              'Tap untuk pilih gambar',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Maksimal 700KB',
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 20),

              // Form card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Nama
                    TextFormField(
                      controller: _namaController,
                      style: const TextStyle(
                          fontSize: 15, color: Color(0xFF2D2D2D)),
                      decoration: _inputDecoration(
                          'Nama Wisata', Icons.place_outlined),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nama wisata wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Provinsi dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedProvinsi,
                      decoration:
                          _inputDecoration('Provinsi', Icons.map_outlined),
                      items: FirestoreService.provinsiList.map((p) {
                        return DropdownMenuItem(value: p, child: Text(p));
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedProvinsi = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Kota
                    TextFormField(
                      controller: _kotaController,
                      style: const TextStyle(
                          fontSize: 15, color: Color(0xFF2D2D2D)),
                      decoration: _inputDecoration(
                          'Kota/Kabupaten', Icons.location_city_outlined),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Kota wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Deskripsi
                    TextFormField(
                      controller: _deskripsiController,
                      style: const TextStyle(
                          fontSize: 15, color: Color(0xFF2D2D2D)),
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Deskripsi',
                        labelStyle:
                            TextStyle(color: Colors.grey.shade500, fontSize: 14),
                        alignLabelWithHint: true,
                        filled: true,
                        fillColor: const Color(0xFFF5F7F5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                              color: Colors.grey.shade200, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                              color: Color(0xFF43A047), width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                              color: Color(0xFFE53935), width: 1),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Deskripsi wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Rating slider
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star_rounded,
                                color: Colors.amber, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Rating: ${_rating.toStringAsFixed(1)}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: _rating,
                          min: 1.0,
                          max: 5.0,
                          divisions: 8,
                          activeColor: const Color(0xFF2E7D32),
                          inactiveColor: const Color(0xFFE8F5E9),
                          label: _rating.toStringAsFixed(1),
                          onChanged: (value) {
                            setState(() {
                              _rating = value;
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('1.0',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade400)),
                            Text('5.0',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade400)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Submit button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        const Color(0xFF2E7D32).withValues(alpha: 0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Text(
                          _isEditing ? 'Perbarui Wisata' : 'Tambah Wisata',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
