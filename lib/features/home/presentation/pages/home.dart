import 'package:flutter/material.dart';
import 'package:local_db/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_db/features/home/presentation/widgets/loading_widget.dart';
import 'package:local_db/features/home/presentation/widgets/todo_list.dart';
import 'package:local_db/utils/ui_helpers.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Center(
          child: Text("ToDo"),
        ),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc()..add(InitialEvent()),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeInitialSuccess) {
              return ListWidget(getData: state.getData);
            } else if (state is HomeInitialLoading) {
              return ShimmerLoadingWidget(
                height: UIHelpers.screenHeight(context),
                width: double.infinity,
              );
            } else if (state is HomeInitialFailure) {
              return ListWidget(getData: state.getData);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
