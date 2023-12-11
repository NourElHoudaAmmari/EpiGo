import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/controllers/image_controller.dart';
import 'package:epigo_project/controllers/profile_controller.dart';
import 'package:epigo_project/models/user_model.dart';
import 'package:epigo_project/screens/User/Profile/profile_screen.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:epigo_project/widgets/build_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}
File? profileImage;
bool _isPasswordVisible = false; 
class _UserDetailScreenState extends State<UserDetailScreen> {
 TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController _imageController  = TextEditingController();

   File? _imageFile;
   bool isObscure = true; // Step 1: Add isObscure variable
Future<void> _pickImage(ImageSource source) async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: source);
  if (pickedImage != null) {
    setState(() {
      _imageFile = File(pickedImage.path);
      _imageController.text = Path.basename(_imageFile!.path);
    });
  }

}
Future<String> _uploadImageToStorage(File file) async {
  final storageRef = FirebaseStorage.instance.ref().child('${Path.basename(file.path)}');
  final uploadTask = storageRef.putFile(file);
  final snapshot = await uploadTask;
  return snapshot.ref.getDownloadURL();
}
  String imageUrl = '';
 ImageController imageController = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {
     ImageController imageController = Get.put(ImageController());
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.primaryColor,
        leading: IconButton(
          //onPressed: () =>Get.back(),
           onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                  },
        icon: const Icon(CupertinoIcons.arrowtriangle_left,color: Colors.black,)),
     title: Text("Modifier Profile", style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic)),
        ),
        body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.done){
if(snapshot.hasData){
 MyUser user = snapshot.data as MyUser;
  imageUrl = user.profilePick!;
  final id = TextEditingController(text: user.id);
  final email =TextEditingController(text: user.email);
    final password =TextEditingController(text: user.password);
      final name =TextEditingController(text: user.name);
        final address =TextEditingController(text: user.address);
        final phone =TextEditingController(text: user.phone);
  return Container(
    
    child: Column(
                children: [
Stack(
  children: [
    SizedBox(
      width: 120,
      height: 120,
      child: InkWell(
        onTap: () async {
          await showModalBottomSheet(
            context: context,
            builder: (_) => BottomSheet(
              onClosing: () {},
              builder: (_) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('Take a photo'),
                    leading: Icon(Icons.camera_alt),
                    onTap: () {
                      _pickImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: Text('Choose from gallery'),
                    leading: Icon(Icons.photo_library),
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        },
       child: ClipOval(
      child: CircleAvatar(
        child: _imageFile != null
            ? Image.file(_imageFile!, fit: BoxFit.cover, width: 120, height: 120)
            : imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    width: 120, 
                    height: 120,
                  )
                : Image.asset('assets/images/profile_pic.png', width: 120, height: 120),
      ),
    ),

      ),
    ),
    Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
        child: IconButton(
          icon: Icon(Icons.edit, color: Colors.white),
          onPressed: () {
            // Handle edit button pressed
          },
        ),
      ),
    ),
  ],
),


                  const SizedBox(height: 50),
                  Form(
                    child:Column(
                      children: [
                        //const SizedBox(height:9),
                      
                          TextFormField(
                            controller: name,
                          decoration: InputDecoration(
                            label: Text("Nom & Prenom"),prefixIcon:Icon(CupertinoIcons.person_fill,color: Colors.blueGrey)),
                        ),
                         const SizedBox(height: 9),
                          TextFormField(
                            controller:email,
                          decoration: InputDecoration(
                            label: Text("Adresse email"),prefixIcon:Icon(CupertinoIcons.envelope,color: Colors.blueGrey)),
                        ),
                         const SizedBox(height:9),
                          TextFormField(
                             keyboardType: TextInputType.number,
                            controller: phone,
                          decoration: InputDecoration(
                            label: Text("Numero de telephone"),prefixIcon:Icon(CupertinoIcons.phone,color: Colors.blueGrey)),
                        ),
                        const SizedBox(height: 9),
                          TextFormField(
                            controller: address,
                            
                          decoration: InputDecoration(
                            hintText: 'Adresse',
                            label: Text("Addresse"),prefixIcon:Icon(CupertinoIcons.text_aligncenter,color: Colors.blueGrey)),
                        ),
                         const SizedBox(height:9),
                          TextFormField(
                            controller: password,
                              obscureText: isObscure, // Step 3: Use isObscure value
                         
                          decoration: InputDecoration(
                            label: Text("Mot de passe"),prefixIcon:Icon(Icons.password_outlined,color: Colors.blueGrey),
                            suffixIcon: IconButton(
      // IconButton to toggle password visibility
      onPressed: () {
        setState(() {
          _isPasswordVisible = !_isPasswordVisible;
        });
      },
      icon: Icon(
        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        color: Colors.grey, // Adjust the color as needed
      ),
    ),
                          ),
                        ),
                          const SizedBox(height:15),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                          onPressed:() async {
                             final profilePicUrl = _imageFile != null ? await _uploadImageToStorage(_imageFile!) : '';
                           // String imagePath = '';
                            final userData =MyUser(
                              id : id.text,
                             email: email.text.trim(),
                             password: password.text.trim(),
                             phone: phone.text.trim(),
                             name: name.text.trim(),
                             address: address.text.trim(),
                            // profilePick:_imageURL, 
                              profilePick: profilePicUrl,
                             
                             );
                              
  try {
        await controller.updateRecord(userData);
       ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text('Données modifiées avec succès!',),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
      elevation: 4,
    ),
  );
        Navigator.push(context,
    MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
         
          SnackBar(content: Text('Une erreur s\'est produite: $e',),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(top: 10,right: 10),
          elevation: 4,
          ),
          
        );
      }
    },
    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(primaryColor), // Couleur de fond
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Rayon de la bordure
        side: BorderSide(color:primaryColor), // Couleur et épaisseur de la bordure
      ),
    ),
  ),
    child: const Text("Modifier Profile", style: TextStyle(color: Colors.black)),
  
  ),
  
                          ),
                 
                      ],
                    )) 
                ]
              ),
  );
}else if(snapshot.hasError){
  return Center(child: Text(snapshot.error.toString())); 
}else{
  return const Center(child: Text("quelque chose s'est mal passé"));
}
              }else{
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        )
        )
        
    );
  }
}