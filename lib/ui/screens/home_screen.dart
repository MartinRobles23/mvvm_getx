import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_getx/data/response/response_status.dart';
import 'package:mvvm_getx/ui/viewModels/view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ViewModel viewModel = Get.find();
    viewModel.getData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            switch (viewModel.baseResponse.value.status) {
              case Status.LOADING:
                return showLoading();
              case Status.SUCCESS:
                return buildPostsList(viewModel);
              case Status.FAILURE:
                return buildResponseError(viewModel);
              default:
                return Container();
            }
          })
        ],
      ),
    );
  }
}

Container showLoading() {
  return Container(
    alignment: Alignment.center,
    child: const CircularProgressIndicator(),
  );
}

Expanded buildPostsList(ViewModel viewModel) {
  return Expanded(
    child: ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      itemCount: viewModel.baseResponse.value.data?.length,
      itemBuilder: (BuildContext context, int index) {
        return ExpansionTile(
          leading: SizedBox(
            width: 50,
            height: 50,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const FlutterLogo()),
          ),
          title: Text(viewModel.baseResponse.value.data![index].title!),
          children: [
            Text(
              viewModel.baseResponse.value.data![index].body!,
              style: const TextStyle(),
            )
          ],
        );
      },
    ),
  );
}

Padding buildResponseError(ViewModel viewModel) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
            alignment: Alignment.center,
            child: Text(
                'Ops, an error occurred. ${viewModel.baseResponse.value.message}')),
        ElevatedButton(
            onPressed: () {
              viewModel.getData();
            },
            child: const Text("Try again"))
      ],
    ),
  );
}
