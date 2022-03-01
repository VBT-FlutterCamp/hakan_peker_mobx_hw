import 'package:dio/dio.dart';
import 'package:flutter_mvvm_mobx_hwa/features/post/model/post_model.dart';
import 'package:mobx/mobx.dart';
part 'post_view_model.g.dart';

class PostViewModel = _PostViewModelBase with _$PostViewModel;

abstract class _PostViewModelBase with Store {
  @observable
  List<PostModel> posts = [];

  @observable
  PageState pageState = PageState.NORMAL;

  final url = "https://jsonplaceholder.typicode.com/posts";
  @observable
  bool isServiceRequestLoading = false;

  @action
  Future<void> getAllPost() async {
    changeRequests();
    final response = await Dio().get(url);

    if (response.statusCode == 200) {
      final responseData = response.data as List;
      posts = responseData.map((e) => PostModel.fromMap(e)).toList();
    }
  }

  @action
  Future<void> getAllPost2() async {
    pageState = PageState.LOADING;
    final response = await Dio().get(url);

    if (response.statusCode == 200) {
      final responseData = response.data as List;
      posts = responseData.map((e) => PostModel.fromMap(e)).toList();
      pageState = PageState.SUCCESS;
    } else {
      pageState = PageState.ERROR;
    }
    changeRequests();
  }

  @action
  void changeRequests() {
    isServiceRequestLoading = !isServiceRequestLoading;
  }
}

enum PageState { LOADING, ERROR, SUCCESS, NORMAL }
