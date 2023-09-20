import 'package:fastaqm_app/Core/constatnts/assets_manager.dart';
import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Features/quran/presentation/views/widgets/quran_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/quran_cubit.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuranCubit, QuranState>(
      listener: (context, state) {},
      builder: (context, state) {
        QuranCubit cubit = QuranCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                    size: 32,
                    color: MyColors.darkBrown,
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const QuranImage(),
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildContainer(context),
                  itemCount: 114,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Padding buildContainer(BuildContext context) {
    Color color = MyColors.lightBrown;
    Color color2 = MyColors.darkBrown;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: AppVariables.appSize(context).width * 0.15,
          width: AppVariables.appSize(context).width * 0.7,
          decoration: BoxDecoration(
            color: MyColors.lightBrown,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "الفاتحة",
                style: GoogleFonts.notoNastaliqUrdu(
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: MyColors.darkBrown,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Image.asset(
                AssetsManager.q1Icon,
                color: MyColors.darkBrown,
                width: AppVariables.appSize(context).width * 0.12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
