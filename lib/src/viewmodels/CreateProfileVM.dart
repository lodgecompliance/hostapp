import 'package:hostapp/src/locator.dart';
import 'package:hostapp/src/model/createUserModel.dart';
import 'package:hostapp/src/service/graphQlQuery.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hostapp/src/screen/Dashboard.dart';
import 'package:hostapp/src/service/navigation_service.dart';
import 'package:hostapp/src/util/constants.dart';
import 'package:hostapp/src/util/customFunctions.dart';
import 'package:hostapp/src/viewmodels/base_model.dart';
import 'package:flutter/material.dart';
import 'package:hostapp/src/service/GraphQLConfiguration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateProfileVM extends BaseModel{
  final GraphQLConfiguration _graphQlConfiq = locator<GraphQLConfiguration>();
final NavigationService _navigationService = locator<NavigationService>();
   final CustomFuntion _customFuntion = locator<CustomFuntion>();
String _errorMessage;
String get getErrorMessage => _errorMessage;


void initialize({String phoneNumber, lastname, phoneCode, name, authuid, email, BuildContext context})async{
  setBusy(true);
   await _graphQlConfiq.getNeccessartyToken(); //MuST CALL THIS BEFRE API 
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String notificationToken  = prefs.getString(Constants.notificationToken);
   String deviceId  = prefs.getString(Constants.deviceID);
    String deviceName  = prefs.getString(Constants.deviceName);
    print('device_id >>> $deviceId');
    print('notification_token >> $notificationToken');
    print('device_name >> $deviceName');
   
     GraphQLClient _client = _graphQlConfiq.clientToQuery();
    
    QueryResult result = await _client.mutate(
      MutationOptions(
          document: gql(insertData),
        variables: {
          "id": authuid,
          'phone_country_code': phoneCode,
          "phone_number": phoneNumber,
          "email": email,
          "name": name,
          "phone" : '$phoneCode $phoneNumber',
          "lastname": lastname,
          "device_ip": '',
          "device_id": deviceId,
          "device_name": deviceName,
          "notification_token": notificationToken,
        },
      )
    ).catchError((e){
      setBusy(false);
      print('Error Occur, ${e.toString()}');
      setErrorMessage(error: e.toString());

        }).timeout(Duration(seconds: 10,), onTimeout: (){
           setBusy(false);
          setErrorMessage(error: 'Server Timeout, Please retry');
        },);

     if (result.data == null) {
        setBusy(false);
             print('Result is Null and Error Occur');
             print(result.exception.graphqlErrors);
             
              setErrorMessage(error: result.exception.graphqlErrors.toString());

         }else if (result.data['createUser'] == null) {
           print('*************Return Data is Null => No Existing Phone Number**************');
           setBusy(false);

         }else{
           String v = 'createUser';
             CreateUserModel createUserModel = new CreateUserModel(
               email: result.data[v]['email'],
               id: result.data[v]['id'],
               name: Name(fName: result.data[v]['name']['first_name'],
                lName: result.data[v]['name']['last_name'],),
                phone: Phone(
              completePhone: result.data[v]['phone_meta']['complete_phone'],
              countryCode: result.data[v]['phone_meta']['country_code'],
              phoneNumber: result.data[v]['phone_meta']['phone_number'],)
            );                
                                //Save details to Secure Storage
        _customFuntion.saveUserData(
          email: createUserModel.email,
          fname: createUserModel.name.fName,
          userID: createUserModel.id,
          lname: createUserModel.name.lName,
          phoneN: createUserModel.phone.phoneNumber,
          completePhone: createUserModel.phone.completePhone,
          phoneCode: createUserModel.phone.countryCode,
        );
        //TODO WHICH MEANS NOTIFICATION DETAILS IS SENT SUCCESSFULLY
        _customFuntion.savedTokenVerification(value: true);
              setBusy(false);
              
             Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return Dashboard(showIndex: 0);
                },
              ),
    );
              
         }
}

setErrorMessage({String error}){
   _errorMessage = error;
    notifyListeners();
  }

}