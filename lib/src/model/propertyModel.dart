class PropertyModel {
  String userId;
  String propertyName;
  String propertyPhone;
  String propertyEmail;
  String propertyImage;
  String propertyRules;
  String propertyAddress;
  String propertyDocument, country;


  PropertyModel(
      {this.userId,
      this.propertyName,
      this.propertyPhone,
      this.propertyEmail,
      this.propertyImage,
      this.propertyRules,
      this.propertyAddress,
      this.propertyDocument,
      this.country});

  PropertyModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    propertyName = json['property_name'];
    propertyPhone = json['property_phone'];
    propertyEmail = json['property_email'];
    propertyImage = json['property_image'];
    propertyRules = json['property_rules'];
    propertyAddress = json['property_address'];
    propertyDocument = json['property_document'];
    country = json['country'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['property_name'] = this.propertyName;
    data['property_phone'] = this.propertyPhone;
    data['property_email'] = this.propertyEmail;
    data['property_image'] = this.propertyImage;
    data['property_rules'] = this.propertyRules;
    data['property_address'] = this.propertyAddress;
    data['property_document'] = this.propertyDocument;
    data['country'] = this.country;
    return data;
  }
}
