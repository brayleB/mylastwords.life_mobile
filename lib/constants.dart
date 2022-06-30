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

const ringToneBaseUrl = "AlarmRingtones/";

//User API Endpoints

//base URL
const baseURL = "http://144.126.210.250/api/public/";
// const baseURL = "http://127.0.0.1:8000";

const loginOthersURL = baseURL + 'api/loginOthers';
const registerOthersURL = baseURL + 'api/registerOthers';
const loginURL = baseURL + 'api/login';
const registerURL = baseURL + 'api/register';
const updateUserURL = baseURL + 'api/edit-user';
const logoutURL = baseURL + 'api/logout';
const userURL = baseURL + 'api/user';

//Notes API Endpoints
const addNoteURL = baseURL + 'api/addnote';
const getNotesURL = baseURL + 'api/getnotes';
const updateNotesURL = baseURL + 'api/editnote';
const deleteNotesUrl = baseURL + 'api/deletenote';

//Logs API Endpoints
const addUserLogURL = baseURL + 'api/addlog';

//Gallery API Endpoints
const uploadImageURL = baseURL + 'api/store-file';
const getImagesURL = baseURL + 'api/view-file';
const deleteImagesURL = baseURL + 'api/delete-file';

