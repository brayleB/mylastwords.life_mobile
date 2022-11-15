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
const baseURL = "https://mylastwordsadmin.online/api/route";
// const baseURL = "http://127.0.0.1:8000";

//User
const loginOthersURL = baseURL + '/loginOthers';
const registerOthersURL = baseURL + '/registerOthers';
const loginURL = baseURL + '/login';
const registerURL = baseURL + '/register';
const updateUserURL = baseURL + '/edit-user';
const logoutURL = baseURL + '/logout';
const userURL = baseURL + '/user';
const forgotPasswordURL = baseURL + '/password/email';
const resetPasswordURL = baseURL + '/password/reset';
const addAppleUserURL = baseURL + '/addAppleAccount';
const getAppleUserURL = baseURL + '/getAppleAccount';
const updateAppleAccountEmailURL = baseURL + '/updateAppleAccountEmail';
const changeProfilePhoto = baseURL + '/changePhoto';
const requestAccountRemovalURL = baseURL + '/requestAccountRemoval';

//Notes API Endpoints
const addNoteURL = baseURL + '/addnote';
const getNotesURL = baseURL + '/getnotes';
const updateNotesURL = baseURL + '/editnote';
const deleteNotesUrl = baseURL + '/deletenote';

//Logs API Endpoints
const addUserLogURL = baseURL + '/addlog';

//Gallery API Endpoints
const uploadImageURL = baseURL + '/store-file';
const getImagesURL = baseURL + '/view-file';
const deleteImagesURL = baseURL + '/delete-file';

