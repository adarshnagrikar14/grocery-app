import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

Future<String> saveItemToDB(String imageUrl, String productName,
    String productSize, String productDescription) async {
  final url = Uri.parse(
    'https://assignme-work.000webhostapp.com/venus/wishlist.php',
  );

  try {
    final response = await http.post(url, body: {
      'userID': FirebaseAuth.instance.currentUser!.uid,
      'imageUrl': imageUrl,
      'productName': productName,
      'productSize': productSize,
      'productDescription': productDescription,
    });

    if (response.statusCode == 200) {
      if (response.body == "Success") {
        return "Success";
      } else {
        print("Item could not be saved. ${response.body}");
        return "Failed";
      }
    } else {
      print("Failed to connect to the server.");
      return "Failed";
    }
  } catch (e) {
    print("An error occurred: $e");
    return "Failed";
  }
}
