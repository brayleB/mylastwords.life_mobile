import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mylastwords/Screens/singletons_data.dart';
import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/toastmessage.dart';

class Paywall extends StatefulWidget {
  final Offering offering;

  const Paywall({Key? key, required this.offering}) : super(key: key);

  @override
  _PaywallState createState() => _PaywallState();
}

updateSubcriptionFunct(String entitlement) async {
   ApiResponse response = await updateSubscription(entitlement);
   if (response.error == null) {       
        EasyLoading.showInfo('Successfull');
      } else {
        ToastMessage().toastMsgDark('${response.error}');
      }
}

class _PaywallState extends State<Paywall> {
  @override
  Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SafeArea(
        child: Wrap(
          children: <Widget>[
            Container(
              height: 70.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: ColorTheme3,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0))),
              child: const Center(
                  child:
                      Text('✨ Subscribe to our service today.', style: TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
))),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(top: 32, bottom: 16, left: 16.0, right: 16.0),
              child: SizedBox(
                child: Text(
                  'Mylastwords Full Access',
                  style: TextStyle(
  color: txtColorDark,
  fontWeight: FontWeight.normal,
  fontSize: 20.0,
),
                ),
                width: double.infinity,
              ),
            ),
            ListView.builder(
              itemCount: widget.offering.availablePackages.length,
              itemBuilder: (BuildContext context, int index) {
                var myProductList = widget.offering.availablePackages;
                return Card(
                  color: ColorTheme9,
                  child: ListTile(
                      onTap: () async {
                      
                        try {
                          CustomerInfo customerInfo =
                              await Purchases.purchasePackage(
                                  myProductList[index]);
                          appData.entitlementIsActive = customerInfo
                              .entitlements.all[entitlementID]!.isActive;
                              updateSubcriptionFunct(customerInfo
                              .entitlements.all[entitlementID]!.identifier);
                        } catch (e) {
                          print(e);
                        }

                        setState(() {});
                        Navigator.pop(context);                   
                      },
                      title: Text(
                        myProductList[index].storeProduct.title,
                        style: TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.normal,
  fontSize: 18.0,
),
                      ),
                      subtitle: Text(
                        myProductList[index].storeProduct.description,
                        style: TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.normal,
  fontSize: 18.0,
).copyWith(
                            fontSize: 10.0),
                      ),
                      trailing: Text(
                          myProductList[index].storeProduct.priceString,
                          style: TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.normal,
  fontSize: 18.0,
))),
                );
              },
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(top: 32, bottom: 16, left: 16.0, right: 16.0),
              child: SizedBox(
                child: Text(
                  footerText,
                  style: TextStyle(
  color: txtColorDark,
  fontWeight: FontWeight.normal,
  fontSize: 18.0,
),
                ),
                width: double.infinity,
              ),
              
            ),
             SizedBox(height: size.height * 0.04),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [GestureDetector(
              onTap: () async { final Uri url = Uri(
                      scheme: 'https',
                      host:'termsofusegenerator.net',
                      path: '/live.php',                    
                      queryParameters: {'token':'jmQDXeXJTMwQqyqeFwMAlHOJJDZETYJA'}                     
                    );
                    await launchUrl(url); },
              child: Text(
                "Terms of use",
                style: TextStyle(
                  color: txtColorDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
            ), Icon(Icons.arrow_forward_ios, size: 15, color: kPrimaryColor,),],),          
          ],
          
        ),
      ),
      
    );
    
  }
}
