class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String email;
  String phone;
  String link;

  Contacts(this.email, this.phone, this.link);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}

class DeviceInfo {
  String name;
  String identifier;
  String version;

  DeviceInfo(this.name, this.identifier, this.version);
}

class Service {
  int id;
  String title;
  String image;

  Service(this.id, this.title, this.image);
}

class BannerAD {
  int id;
  String link;
  String title;
  String image;

  BannerAD(this.id, this.link, this.title, this.image);
}

class Store {
  int id;
  String title;
  String image;

  Store(this.id, this.title, this.image);
}

class HomeData {
  List<Service> services;
  List<BannerAD> banners;
  List<Store> stores;

  HomeData(this.services, this.banners, this.stores);
}

class HomeObject {
  HomeData? data;

  HomeObject(this.data);
}

class StoreDetailsObject {
  String image;
  int id;
  String title;
  String details;
  String services;
  String about;

  StoreDetailsObject(
    this.image,
    this.id,
    this.title,
    this.details,
    this.services,
    this.about,
  );
}
