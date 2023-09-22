import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/azkar_cubit.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AzkarCubit()..fetchAzkarData(),
      child: BlocConsumer<AzkarCubit, AzkarState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [Text("اذكار ")],
            ),
          );
        },
      ),
    );
  }
}
