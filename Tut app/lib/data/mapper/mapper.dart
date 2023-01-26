import 'package:mvvm_project_1/app/constant.dart';
import 'package:mvvm_project_1/app/extensions.dart';

// to convert the response into a non nullable object (model)

import 'package:mvvm_project_1/data/responses/responses.dart';
import 'package:mvvm_project_1/domain/model/model.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id?.orEmpty() ?? Constants.EMPTY,
        this?.name?.orEmpty() ?? Constants.EMPTY,
        this?.numOfNotifications?.orZero() ?? Constants.ZERO);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
        this?.email?.orEmpty() ?? Constants.EMPTY,
        this?.phone?.orEmpty() ?? Constants.EMPTY,
        this?.link?.orEmpty() ?? Constants.EMPTY);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
        this?.customer?.toDomain(), this?.contacts?.toDomain());
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? Constants.EMPTY;
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
      this?.id.orZero() ?? Constants.ZERO,
      this?.title.orEmpty() ?? Constants.EMPTY,
      this?.image.orEmpty() ?? Constants.EMPTY,
    );
  }
}

extension BannerResponseMapper on BannerResponse? {
  BannerAD toDomain() {
    return BannerAD(
      this?.id.orZero() ?? Constants.ZERO,
      this?.link.orEmpty() ?? Constants.EMPTY,
      this?.title.orEmpty() ?? Constants.EMPTY,
      this?.image.orEmpty() ?? Constants.EMPTY,
    );
  }
}

extension StoresResponseMapper on StoresResponse? {
  Store toDomain() {
    return Store(
      this?.id.orZero() ?? Constants.ZERO,
      this?.title.orEmpty() ?? Constants.EMPTY,
      this?.image.orEmpty() ?? Constants.EMPTY,
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> Mapservices = (this
                ?.data
                ?.services
                ?.map((serviceResponse) => serviceResponse.toDomain()) ??
            Iterable.empty())
        .cast<Service>()
        .toList();
    List<BannerAD> Mapbanners = (this?.data?.banners?.map(
                  (bannerResponse) => bannerResponse.toDomain(),
                ) ??
            Iterable.empty())
        .cast<BannerAD>()
        .toList();
    List<Store> Mapstores = (this?.data?.stores?.map(
                  (storeResponse) => storeResponse.toDomain(),
                ) ??
            Iterable.empty())
        .cast<Store>()
        .toList();

    var data = HomeData(Mapservices, Mapbanners, Mapstores);
    return HomeObject(data);
  }
}

extension StoreDetailsResponseMapper on StoreDetailsResponse? {
  StoreDetailsObject toDomain() {
    return StoreDetailsObject(
      this?.image ?? Constants.EMPTY,
      this?.id ?? Constants.ZERO,
      this?.title ?? Constants.EMPTY,
      this?.details ?? Constants.EMPTY,
      this?.services ?? Constants.EMPTY,
      this?.about ?? Constants.EMPTY,
    );
  }
}
