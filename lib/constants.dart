import 'package:flutter/material.dart';

//Colors
const kPrimaryColor = Color.fromARGB(159, 46, 42, 19);
const kPrimaryLightColor = Color.fromARGB(255, 223, 223, 190);
const txtColorDark = Color.fromARGB(255, 54, 54, 29);
const txtColorLight = Color.fromARGB(255, 255, 255, 217);
const txtColorWhite = Color.fromARGB(255, 255, 255, 255);
const darkBackground = Color.fromARGB(255, 40, 40, 32);
const lightBackground = Color.fromARGB(255, 253, 253, 235);
const headerBackgroundColor = Color.fromARGB(255, 117, 117, 88);

//Color Theme
const ColorTheme1 = Color.fromARGB(255, 255, 255, 217);
const ColorTheme2 = Color.fromARGB(255, 231, 231, 172);
const ColorTheme3 = Color.fromARGB(255, 203, 203, 145);
const ColorTheme4 = Color.fromARGB(255, 178, 178, 114);
const ColorTheme5 = Color.fromARGB(255, 160, 160, 100);
const ColorTheme6 = Color.fromARGB(255, 130, 130, 74);
const ColorTheme7 = Color.fromARGB(255, 113, 113, 52);
const ColorTheme8 = Color.fromARGB(255, 88, 88, 29);
const ColorTheme9 = Color.fromARGB(255, 69, 69, 14);
const ColorTheme10 = Color.fromARGB(255, 60, 60, 1);
const ColorThemeBlueGray = Colors.blueGrey;


const ringToneBaseUrl = "assets/AlarmRingtones/";

//User API Endpoints

//base URL
const baseURL = "https://mylastwordsadmin.online/";
// const baseURL = "http://127.0.0.1:8000";

//User
const loginOthersURL = baseURL + 'api/route/loginOthers';
const registerOthersURL = baseURL + 'api/route/registerOthers';
const loginURL = baseURL + 'api/route/login';
const registerURL = baseURL + 'api/route/register';
const updateUserURL = baseURL + 'api/route/edit-user';
const logoutURL = baseURL + 'api/route/logout';
const userURL = baseURL + 'api/route/user';
const forgotPasswordURL = baseURL + 'api/route/password/email';
const resetPasswordURL = baseURL + 'api/route/password/reset';
const addAppleUserURL = baseURL + 'api/route/addAppleAccount';
const getAppleUserURL = baseURL + 'api/route/getAppleAccount';
const updateAppleAccountEmailURL = baseURL + 'api/route/updateAppleAccountEmail';
const changeProfilePhoto = baseURL + 'api/route/changePhoto';
const requestAccountRemovalURL = baseURL + 'api/route/requestAccountRemoval';

//Notes API Endpoints
const addNoteURL = baseURL + 'api/route/addnote';
const getNotesURL = baseURL + 'api/route/getnotes';
const updateNotesURL = baseURL + 'api/route/editnote';
const deleteNotesUrl = baseURL + 'api/route/deletenote';

//Logs API Endpoints
const addUserLogURL = baseURL + 'api/route/addlog';

//Gallery API Endpoints
const uploadImageURL = baseURL + 'api/route/store-file';
const getImagesURL = baseURL + 'api/route/view-file';
const deleteImagesURL = baseURL + 'api/route/delete-file';

const entitlementID = 'subscribed';

//TO DO: add your subscription terms and conditions
const footerText =
    "You will have an access to all of your journals (lastwords) and pictures at any time.";

//TO DO: add the Apple API key for your app from the RevenueCat dashboard: https://app.revenuecat.com
const appleApiKey = 'appl_ZwNTODEADdtIVZEOKMsMWogJoWt';

//TO DO: add the Google API key for your app from the RevenueCat dashboard: https://app.revenuecat.com
const googleApiKey = 'googl_api_key';

//TO DO: add the Amazon API key for your app from the RevenueCat dashboard: https://app.revenuecat.com
const amazonApiKey = 'amazon_api_key';

