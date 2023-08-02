import 'package:advanced_flutter/data/data_source/remote_data_source.dart';
import 'package:advanced_flutter/data/mapper/mapper.dart';
import 'package:advanced_flutter/data/network/error_handler.dart';
import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/data/network/network_info.dart';
import 'package:advanced_flutter/data/request/request.dart';
import 'package:advanced_flutter/domain/model/model.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:advanced_flutter/data/mapper/mapper.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return(Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
