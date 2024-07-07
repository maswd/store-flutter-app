import 'package:store/common/http_client.dart';
import 'package:store/data/banner.dart';
import 'package:store/data/source/banner_data_source.dart';

final bannerRepository = BannerRepository(BannerRemoteDataSource(httpClient));

abstract class IBannerRepository {
  Future<List<BannerEntity>> getAll();
}

class BannerRepository implements IBannerRepository {
  final IBannerDataSource dataSource;
  BannerRepository(this.dataSource);

  @override
  Future<List<BannerEntity>> getAll() {
    return dataSource.getAll();
  }
}
