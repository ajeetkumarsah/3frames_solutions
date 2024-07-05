import 'package:get/get.dart';
import 'package:new_app/data/repo/landing_repo.dart';
import 'package:new_app/model/post_model.dart';
import 'package:new_app/model/response/response_model.dart';

class LandingController extends GetxController {
  final LandingRepo landingRepo;

  LandingController({required this.landingRepo});

  @override
  void onInit() {
    super.onInit();
    getPosts();
  }

  //bool
  bool _isLoading = false;
  bool get isloading => _isLoading;

//List
  List<PostModel> posts = [];

  Future<ResponseModel> getPosts() async {
    _isLoading = true;
    update();
    Response response = await landingRepo.getPosts(
        url: 'https://jsonplaceholder.typicode.com/posts');
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      final data = response.body;
      if (data != null) {
        posts = List<PostModel>.from(data!.map((x) => PostModel.fromJson(x)));
      }
      responseModel = ResponseModel(true, 'Success');
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      //Logout the session
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
