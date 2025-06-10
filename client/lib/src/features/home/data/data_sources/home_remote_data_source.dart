// import '../models/house_model.dart';
// import '../../../../core/errors/failures.dart';
// import 'package:dio/dio.dart';

// abstract class HomeRemoteDataSource {
//   Future<List<HouseModel>> getFeaturedHouses();
// }

// class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
//   final Dio dio;

//   HomeRemoteDataSourceImpl({required this.dio});

//   @override
//   Future<List<HouseModel>> getFeaturedHouses() async {
//     try {
//       final response = await dio.get('/housetype?type_id=1');
      
//       if (response.statusCode == 200) {
//         final data = response.data['data'] as List;
//         return data.map((json) => HouseModel.fromJson(json)).toList();
//       } else {
//         throw ServerFailure(
//           message: response.data['message'] ?? 'Failed to load houses',
//           statusCode: response.statusCode,
//         );
//       }
//     } on DioException catch (e) {
//       throw ServerFailure(
//         message: e.response?.data['message'] ?? e.message ?? 'Network error',
//         statusCode: e.response?.statusCode,
//       );
//     } catch (e) {
//       throw ServerFailure(
//         message: e.toString(),
//       );
//     }
//   }
// }