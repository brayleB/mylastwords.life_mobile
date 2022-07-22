// ignore_for_file: deprecated_member_use

import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mylastwords/Screens/GalleryScreen/Components/previewImage.dart';
import 'package:mylastwords/Screens/GalleryScreen/Components/viewImage.dart';
import 'package:mylastwords/Services/gallery_services.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/components/header_tab.dart';


class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File? fileImage;
  final picker = new ImagePicker();  

  Future getImage() async {
    try{
      final pickedFile = await picker.getImage(source: ImageSource.gallery, maxHeight: 500, maxWidth: 500);    
          setState(() {
            if (pickedFile != null) {       
              fileImage = File(pickedFile.path);              
              print('Image selected : '+fileImage.toString());
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PreviewImage(fileImage: fileImage)));
            } else {
              ToastMessage().toastMsgError('No image selected');
            }
          });
    }catch(e){
      ToastMessage().toastMsgError(e.toString());
    }    
  }

  Future takeImage() async {
     try{
        final pickedFile = await picker.getImage(source: ImageSource.camera, maxHeight: 500, maxWidth: 400, preferredCameraDevice: CameraDevice.rear);
          setState(() {
            if (pickedFile != null) {
              fileImage = File(pickedFile.path);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PreviewImage(fileImage: fileImage)));
            } else {
              print('No image selected.');
            }
          });        
     }catch(e){
        ToastMessage().toastMsgError(e.toString());
     }
  }     

  @override
  void initState() {
    super.initState();
  }


         
     

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
      return Scaffold(
          appBar: HeaderTab(
          backgroundcolor: headerBackgroundColor,
          title: 'Gallery',
          press: () {            
          },
          iconbtn: Icons.info_outline,
        ),
        backgroundColor: lightBackground,
        body:Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),        
        child: FutureBuilder(
          future: fetchPhotos(),
          builder: (BuildContext context, AsyncSnapshot listData) {
            if (!listData.hasData) {
              return Center(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
            } else {
              if(listData.data.length==0){
                return Center(
                      child: Center(
                        child:  Text(
                                'No Photos',
                                style: TextStyle(
                                  color: txtColorDark,
                                  fontSize: 30,
                                ),
                              ),
                      ),
                    );
              }
              else{
                return GridView.builder(
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
                itemCount: listData.data.length,
                itemBuilder: (BuildContext context, int position) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Card(
                        elevation: 5.0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0))),
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                             Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewImage(
                                      img: listData.data,
                                      pos: position)));
                          }, 
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      baseURL+listData.data[position].title),
                                  fit: BoxFit.cover),                                  
                            ),
                            height: 100,
                            width: size.width*0.3,
                          ),   )                     
                      ),                      
                    ],
                  );
                },
              );
              }
            }
          },
        ),   
      ),
      floatingActionButton: Container(
        height: size.height * 0.17,
        width: size.width * 0.17, 
        margin: EdgeInsets.only(right: size.width*0.05),      
        child: FloatingActionButton(
            onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(Icons.camera_alt),
                        title: Text('Camera'),
                        onTap: () {
                          takeImage();
                        },
                      ),
                      ListTile(
                          leading: Icon(Icons.image),
                          title: Text('Gallery'),
                          onTap: () {
                            getImage();
                          }),
                    ],
                  ),
                );
            },
            child: Icon(Icons.add, size: 30),
            backgroundColor: headerBackgroundColor,               
            ),
          ),      
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );       
    }
}

// class Body extends StatefulWidget {
//   const Body({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   File? fileImage;
//   final picker = ImagePicker();

//   Future getImage() async {
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         fileImage = File(pickedFile.path);
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => PreviewImage(fileImage: fileImage)));
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   Future takeImage() async {
//     final pickedFile = await picker.getImage(source: ImageSource.camera);

//     setState(() {
//       if (pickedFile != null) {
//         fileImage = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: HeaderTab(
//         backgroundcolor: headerBackgroundColor,
//         title: 'Gallery',
//         press: () {
//           showModalBottomSheet(
//             context: context,
//             builder: (context) => Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ListTile(
//                   leading: Icon(Icons.camera_alt),
//                   title: Text('Camera'),
//                   onTap: () {
//                     takeImage();
//                   },
//                 ),
//                 ListTile(
//                     leading: Icon(Icons.image),
//                     title: Text('Gallery'),
//                     onTap: () {
//                       getImage();
//                     }),
//               ],
//             ),
//           );
//         },
//         iconbtn: Icons.add_a_photo,
//       ),
//       backgroundColor: darkBackground,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Expanded(
//                 child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: (GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                 ),
//                 itemBuilder: (context, snapshot) {                  
//                   return RawMaterialButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => ViewImage(
//                                   img: sampleGalleryData[index]
//                                       .imageUrl
//                                       .toString())));
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(2),
//                         image: DecorationImage(
//                             image: NetworkImage(
//                                 sampleGalleryData[index].imageUrl.toString()),
//                             fit: BoxFit.cover),
//                       ),
//                     ),
//                   );
//                 },
//                 itemCount: sampleGalleryData.length,
//               )),
//             ))
//           ],
//         ),
//       ),
//     );
//   }
// }
