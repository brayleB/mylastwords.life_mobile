import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mylastwords/Screens/DashBoard/dashboard.dart';
import 'package:mylastwords/Services/gallery_services.dart';
import 'package:mylastwords/components/confirmation_dialogue.dart';
import 'package:mylastwords/components/header_tab.dart';
import 'package:mylastwords/components/header_tab_back.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ViewImage extends StatefulWidget {
  final PageController pageController;
  final List img;
  final int pos;

  ViewImage({required this.img, required this.pos}) : pageController = PageController(initialPage: pos);

  @override
    _ViewImageState createState() => _ViewImageState();
  }
class _ViewImageState extends State<ViewImage> {
  late int posImg = widget.img[widget.pos].id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderTab(
        backgroundcolor: headerBackgroundColor,
        title: '',
        iconbtn: Icons.delete_outline_rounded,
        press: () {
         showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Confirmation'),
                content: Text('Do you really want to delete this Image?'),
                backgroundColor: lightBackground,
                actions: <Widget>[
                  new TextButton(
                    onPressed: () async {  
                      ApiResponse response = await deleteImage(this.posImg);
                      if(response.error==null){
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DashBoard();
                            },
                          ),
                        );
                        EasyLoading.showSuccess('Image removed');
                      }
                      else{
                        ToastMessage().toastMsgError(response.error.toString());
                      }
                    },
                    child: Text(
                      'Yes',
                      style: TextStyle(
                          color: txtColorDark, fontSize: 17),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop(
                          false); 
                    },
                    child: Text(
                      'No',
                      style: TextStyle(
                          color: txtColorDark, fontSize: 15),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      body: PhotoViewGallery.builder(        
        pageController: widget.pageController,
        itemCount: widget.img.length, 
        builder: (context, index){
        final urlImages = widget.img[index].title;
        return PhotoViewGalleryPageOptions(                    
          imageProvider: NetworkImage(baseURL+urlImages),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.contained * 6,          
          );
        },
      onPageChanged: (posImg)=>setState(()=>this.posImg==widget.img[posImg].id),
      ),
    );
  }
}
