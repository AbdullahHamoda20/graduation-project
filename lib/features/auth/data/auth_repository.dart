import 'package:dio/dio.dart';
import 'package:pcos_app/core/network/api_error.dart';
import 'package:pcos_app/core/network/api_exceptions.dart';
import 'package:pcos_app/core/network/api_service.dart';
import 'package:pcos_app/core/network/dio_clint.dart';
import 'package:pcos_app/core/network/perf_helper.dart';
import 'package:pcos_app/features/auth/data/auth_model.dart';

class AuthRepo{
 ApiServices apiServices = ApiServices();


 //login
 Future<UserModel?> login(String email, String password) async {

  try {
   final response = await apiServices.post(
    "Account/login",
    {'email': email, 'password': password},
   );

   if (response is ApiError) {
    throw response;
   }

   if (response is Map<String, dynamic>) {

    final message = response["message"];

    if (message == "Invalid Email or Password!") {
     throw ApiError(message: message);
    }

    final user = UserModel.fromJson(response);

    if (user.token != null) {
     await PrefHelper.saveToken(user.token!);
     await PrefHelper.saveRefreshToken(user.refreshToken!);
    }

    return user;
   }

   throw ApiError(message: "Unexpected response format");

  } on DioError catch (e) {
   throw ApiExpectations.handleError(e);
  } catch (e) {
   throw ApiError(message: e.toString());
  }
 }


//register
 Future<UserModel?> signup(String username, String email, String password, String confirmPassword) async {
  try {
   final response = await apiServices.post(
    "Account/register",
    {
     "userName": username,
     "email": email,
     "password": password,
     "confirmPassword": confirmPassword,
    },
   );

   //  case 1: string error
   if (response is String) {
    throw ApiError(message: response);
   }

   // case 2: validation errors (errors map)
   if (response is Map<String, dynamic>) {
    if (response.containsKey("errors")) {
     final errors = response["errors"] as Map<String, dynamic>;

     // خد أول error
     final firstError = errors.values.first[0];

     throw ApiError(message: firstError);
    }

    //  success
    final user = UserModel.fromJson(response);

    if (user.token != null) {
     await PrefHelper.saveToken(user.token!);
    }

    return user;
   }

   throw ApiError(message: "Unexpected response format");

  } on DioException catch (e) {
   throw ApiExpectations.handleError(e);
  } catch (e) {
   throw ApiError(message: e.toString());
  }

 }


//get profile
 Future<UserModel?> getProfileData() async {
  try {
   final response = await apiServices.get("Dashboard");

   if (response is Map<String, dynamic>) {
    return safeUserResponse(response);
   }

   throw ApiError(message: "Unexpected response format");

  } on DioException catch (e) {
   throw ApiExpectations.handleError(e);
  } catch (e) {
   throw ApiError(message: e.toString());
  }
 }


 //update
 Future<UserModel?> updataProfileData({required String username, required String email,}) async {
  try {final response = await apiServices.put("Account/update-profile",{
     "userName": username,
     "email": email,
    },);

   if (response is Map<String, dynamic>) {
    return safeUserResponse(response);
   }

   throw ApiError(message: "Unexpected response format");

  } on DioException catch (e) {
   throw ApiExpectations.handleError(e);
  } catch (e) {
   throw ApiError(message: e.toString());
  }
 }


 // change pass
Future <UserModel?> changePass({required String currentPass,required String newPass,required String confirmPass})async{
 try {
  final response = await apiServices.post(
   "Account/change-password",
   {'currentPassword': currentPass, 'newPassword': newPass,'confirmNewPassword':confirmPass},
  );

  if (response is ApiError) {
   throw response;
  }

  if (response is Map<String, dynamic>) {

   final message = response["message"];

   if (message == "Incorrect password.") {
    throw ApiError(message: message);
   }

   final user = UserModel.fromJson(response);

   return user;
  }

  throw ApiError(message: "Unexpected response format");

 } on DioError catch (e) {
  throw ApiExpectations.handleError(e);
 } catch (e) {
  throw ApiError(message: e.toString());
 }
}


//get username
 Future<UserModel?> getUsername() async {
  try {
   final response = await apiServices.get("Dashboard");

   return UserModel.fromJson(response);

  } on DioException catch (e) {
   throw ApiExpectations.handleError(e);
  } catch (e) {
   throw ApiError(message: e.toString());
  }
 }


 Future<String> sendContactMessage({required String name, required String email, required String message,}) async {
  try {
   final response = await apiServices.post("Contact/send", {"name": name, "email": email, "message": message},);

   // 🟥 لو رجع ApiError
   if (response is ApiError) {
    throw response;
   }

   // 🟩 success
   if (response is Map<String, dynamic>) {
    return response["message"] ?? "Message sent successfully";
   }

   throw ApiError(message: "Unexpected response format");

  } on DioException catch (e) {
   throw ApiExpectations.handleError(e);
  } catch (e) {
   throw ApiError(message: e.toString());
  }
 }


 UserModel safeUserResponse(Map<String, dynamic> response) {
  if (response["isAuthenticated"] == false) {
   throw ApiError(message: response["message"] ?? "Unauthorized");
  }

  if (response.containsKey("errors")) {
   final errors = response["errors"] as Map<String, dynamic>;
   final firstError = (errors.values.first as List).first;
   throw ApiError(message: firstError);
  }

  return UserModel.fromJson(response);
 }
}