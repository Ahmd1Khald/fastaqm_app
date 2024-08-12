// // //quran body design
// //
// Padding(
// padding: EdgeInsets.only(bottom: i == 113 ? 50.0 : 0),
// child: Column(
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// SizedBox(
// width: AppVariables.appSize(context).width * 0.55,
// height: AppVariables.appSize(context).width * 0.17,
// child: Container(
// decoration: BoxDecoration(
// color: MyColors.lightBrown,
// borderRadius: BorderRadius.circular(30),
// ),
// child: TextButton(
// child: Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// //ArabicSuraNumber(i: i),
// if (quraan.getPlaceOfRevelation(i + 1) ==
// "Madinah") ...[
// Image.asset(
// AssetsManager.masjedIcon,
// width: 30.sp,
// ),
// ] else ...[
// Image.asset(
// AssetsManager.makaaIcon,
// width: 30.sp,
// ),
// ],
// const Spacer(),
// Text(
// arabicName[i]['name'],
// style: GoogleFonts.noticiaText(
// fontSize: 24.sp,
// fontWeight: FontWeight.w600,
// color: MyColors.darkBrown,
// ),
// textDirection: TextDirection.rtl,
// ),
// ],
// ),
// onPressed: () {
// fabIsClicked = false;
// //playQuran(sura: 114);
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => SurahBuilder(
// arabic: quran[0],
// sura: i,
// suraName: arabicName[i]['name'],
// ayah: 0,
// )),
// );
// },
// ),
// ),
// ),
// SizedBox(
// width: 10.w,
// ),
// //play sura
// CircleAvatar(
// backgroundColor: MyColors.darkBrown,
// radius: 25.sp,
// child: InkWell(
// onTap: () {
// if (audioValue != null) {
// if (isPlay == i + 1) {
// pause = !pause;
// if (replay) {
// playQuran(
// suraUrl: getAudioUrl(
// audioValue: audioValue ?? "",
// sura: i + 1));
// //setState(() {});
// } else if (pause) {
// pauseQuran();
// } else {
// resumeQuran();
// }
// setState(() {});
// } else {
// isPlay = i + 1;
// pause = false;
// replay = false;
// playQuran(
// suraUrl: getAudioUrl(
// audioValue: audioValue ?? "",
// sura: i + 1));
// setState(() {});
// }
// } else {
// playQuran(suraUrl: "");
// }
// },
// child: Icon(
// isPlay == i + 1 && replay
// ? Icons.replay
//     : !pause && isPlay == i + 1
// ? Icons.pause
//     : Icons.play_arrow,
// color: Colors.white,
// ),
// ),
// ),
// SizedBox(
// width: 7.w,
// ),
// //download sura
// CircleAvatar(
// backgroundColor: MyColors.darkBrown,
// radius: 25.sp,
// child: InkWell(
// onTap: () {
// bool clicked = false;
// //You can download a single file
// if (audioValue != null) {
// print(getAudioUrl(
// audioValue: audioValue ?? "", sura: i + 1));
// FileDownloader.downloadFile(
// url: getAudioUrl(
// audioValue: audioValue ?? "",
// sura: i + 1),
// name:
// "فاستقم - ${arabicName[i]['name']}", //(optional)
// onProgress:
// (String? fileName, double? progress) {
// isDownload = i + 1;
// setState(() {
// loadingDownload = true;
// });
// print(
// 'FILE fileName HAS PROGRESS $progress');
// },
// onDownloadCompleted: (String path) {
// setState(() {
// loadingDownload = false;
// });
// customSnackBar(
// context: context,
// title: 'تم التحميل بنجاح');
// },
// onDownloadError: (String error) {
// setState(() {
// loadingDownload = false;
// });
// customSnackBar(
// context: context,
// title: 'تأكد من اتصالك بالانترنيت');
// });
// } else {
// customSnackBar(
// context: context,
// title: 'اختر صوت القارئ أولا');
// }
// },
// child: loadingDownload && isDownload == i + 1
// ? const CircularProgressIndicator(
// color: MyColors.lightBrown,
// )
//     : const Icon(
// Icons.download,
// color: Colors.white,
// ),
// ),
// ),
// ],
// ),
// if (isPlay == i + 1) ...[
// SizedBox(
// width: double.infinity,
// height: AppVariables.appSize(context).width * 0.15,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text(formatTime(position)),
// Slider(
// min: 0,
// max: duration.inSeconds.toDouble(),
// value: position.inSeconds.toDouble(),
// activeColor: MyColors.darkBrown,
// onChanged: (double value) async {
// final position =
// Duration(seconds: value.toInt());
// await play.seek(position);
// },
// ),
// Text(formatTime(duration)),
// ],
// ),
// ),
// ],
// ],
// ),
// ),
