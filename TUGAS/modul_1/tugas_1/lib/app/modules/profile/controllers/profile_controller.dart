import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  RxString imagePath = ''.obs;

  final ImagePicker _picker = ImagePicker();

  // Method untuk memilih gambar dari galeri
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path;
    }
  }

  // Method untuk sign out
  Future<void> signOut() async {
    // Implementasi logika sign out, misalnya menghapus token atau data pengguna
    // Setelah sign out, kembali ke halaman login
    Get.toNamed('login'); // Ganti '/login' dengan nama route untuk halaman login Anda
  }
}
