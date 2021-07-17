import 'package:flutter/material.dart';
import 'package:hostapp/src/screen/AddPropertyScreen.dart';
import 'package:hostapp/src/viewmodels/AddProperty_view_mode.dart';
import 'package:stacked/stacked.dart';

class AddPropertyPortrait extends ViewModelWidget<AddPropertyViewModel> {
  @override
  Widget build(BuildContext context, AddPropertyViewModel model) {
    //print('AM Prostrait***************');
    return Scaffold(
      body: AddProprtyUI(model),
    );
  }
}

class AddPropertyLandscape extends ViewModelWidget<AddPropertyViewModel> {
  @override
  Widget build(BuildContext context, AddPropertyViewModel model) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(child: 
     SingleChildScrollView(
         child: AddProprtyUI(model),
     ) 
    ,),
      ),
    );
  }
}

class AddPropertyTablet extends ViewModelWidget<AddPropertyViewModel> {
  @override
  Widget build(BuildContext context, AddPropertyViewModel model) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AddProprtyUI(model),
      ),
    );
  }
}