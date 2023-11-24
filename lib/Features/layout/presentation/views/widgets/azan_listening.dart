import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/constatnts/colors.dart';

class AzanListening extends StatefulWidget {
  const AzanListening({Key? key}) : super(key: key);

  @override
  State<AzanListening> createState() => _AzanListeningState();
}

class _AzanListeningState extends State<AzanListening> {
  bool isPlayed = false;
  Future<void> _playAzan() async {
    try {
      // Load the audio file from assets
      await AppVariables.assetsAudioPlayer
          .open(
            Audio("assets/audios/azan.mp3"),
          )
          .then((value) {});
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _pauseAzan() async {
    try {
      // Load the audio file from assets
      await AppVariables.assetsAudioPlayer.stop();
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () async {
            setState(() {
              isPlayed = !isPlayed;
            });
            isPlayed ? _playAzan() : _pauseAzan();
          },
          icon: Icon(isPlayed ? Icons.pause : Icons.play_arrow),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          'سماع الآذان',
          style: GoogleFonts.noticiaText(
            color: MyColors.darkBrown,
            fontSize: 18.sp,
          ),
        ),
      ],
    );
  }
}
