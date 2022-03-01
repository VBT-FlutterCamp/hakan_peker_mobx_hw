import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mvvm_mobx_hwa/features/post/model/post_model.dart';

import '../viewModel/post_view_model.dart';

class PostView extends StatelessWidget {
  final _viewModel = PostViewModel();
  PostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _viewModel.getAllPost2();
        },
      ),
      body: mainPage(),
    );
  }

  Center mainPage() {
    return Center(child: Observer(builder: (_) {
      switch (_viewModel.pageState) {
        case PageState.LOADING:
          return const CircularProgressIndicator();
        case PageState.SUCCESS:
          return listviewBuilder();
        case PageState.ERROR:
          return const Center(child: Text("Error"));

        default:
          return const FlutterLogo();
      }
    }));
  }

  AppBar buildAppbar() {
    return AppBar(
      title: const Text("Mobx"),
      leading: Observer(builder: (_) {
        return Visibility(
          visible: _viewModel.isServiceRequestLoading,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>((Colors.white)),
            ),
          ),
        );
      }),
    );
  }

  Widget listviewBuilder() {
    return Observer(builder: (_) {
      return ListView.builder(
        itemCount: _viewModel.posts.length,
        itemBuilder: (BuildContext context, int index) {
          return cardListTile(index);
        },
      );
    });
  }

  Card cardListTile(int index) {
    return Card(
      child: ListTile(
        title: Text(_viewModel.posts[index].title ?? ""),
        subtitle: Text(_viewModel.posts[index].body ?? ""),
        trailing: Text(_viewModel.posts[index].id.toString()),
      ),
    );
  }
}
