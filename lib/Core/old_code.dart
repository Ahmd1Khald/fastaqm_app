// Expanded(
// child: ListView.separated(
// itemBuilder: (context, i) => Padding(
// padding: const EdgeInsets.symmetric(horizontal: 15.0),
// child: TextButton(
// onPressed: () {
// fabIsClicked = false;
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => SurahBuilder(
// arabic: quran[0],
// sura: i,
// suraName: arabicName[i]['name'],
// ayah: 0,
// ),
// ),
// );
// },
// child: Container(
// width: double.infinity,
// height: isPlay == i + 1
// ? AppVariables.appSize(context).width * 0.4
//     : AppVariables.appSize(context).width * 0.35,
// decoration: BoxDecoration(
// color: MyColors.lightBrown,
// borderRadius: BorderRadius.circular(12),
// ),
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 10.0, vertical: 10),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Column(
// crossAxisAlignment: CrossAxisAlignment.end,
// children: [
// SizedBox(
// width: AppVariables.appSize(context).width *
// 0.47,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// InkWell(
// onTap: () {
// print(
// "audioValue++++++++++++++++++");
// print(audioValue);
// if (audioValue != null) {
// FileDownloader.downloadFile(
// url: getAudioUrl(
// audioValue: audioValue!,
// sura: i + 1,
// ),
// name:
// "فاستقم - $audioValue سورة ${arabicName[i]['name']}",
// onProgress: (String? fileName,
// double? progress) {
// setState(() {
// loadingDownload = true;
// isDownload = i + 1;
// });
// },
// onDownloadCompleted:
// (String path) {
// setState(() {
// loadingDownload = false;
// });
// customSnackBar(
// context: context,
// title:
// 'تم التحميل بنجاح');
// },
// onDownloadError:
// (String error) {
// setState(() {
// loadingDownload = false;
// });
// customSnackBar(
// context: context,
// title:
// 'تأكد من اتصالك بالانترنيت');
// },
// );
// } else {
// customSnackBar(
// context: context,
// title:
// 'اختر صوت القارئ أولا');
// }
// },
// child: loadingDownload &&
// isDownload == i + 1
// ? const CircularProgressIndicator(
// color: MyColors.darkBrown,
// strokeWidth: 7,
// )
//     : const Icon(Icons.download,
// color: MyColors.darkBrown),
// ),
// const Spacer(),
// Text(
// arabicName[i]['name'],
// style: GoogleFonts.noticiaText(
// fontSize: 26.sp,
// fontWeight: FontWeight.w600,
// color: MyColors.darkBrown,
// ),
// textDirection: TextDirection.rtl,
// textAlign: TextAlign.right,
// ),
// ],
// ),
// ),
// SizedBox(height: 10.h),
// SizedBox(
// width: AppVariables.appSize(context).width *
// 0.47,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// CircleAvatar(
// backgroundColor: MyColors.darkBrown,
// radius: 20.sp,
// child: InkWell(
// onTap: () {
// if (audioValue != null) {
// if (isPlay == i + 1) {
// pause = !pause;
// if (replay) {
// playQuran(
// suraUrl: getAudioUrl(
// sura: i + 1,
// audioValue:
// audioValue!));
// } else if (pause) {
// pauseQuran();
// } else {
// resumeQuran();
// }
// } else {
// setState(() {
// isPlay = i + 1;
// pause = false;
// replay = false;
// });
// playQuran(
// suraUrl: getAudioUrl(
// sura: i + 1,
// audioValue:
// audioValue!));
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
// const Spacer(),
// SizedBox(
// width: AppVariables.appSize(context)
//     .width *
// 0.15),
// Image.asset(
// quraan.getPlaceOfRevelation(i + 1) ==
// "Madinah"
// ? AssetsManager.masjedIcon
//     : AssetsManager.makaaIcon,
// height: 35.sp,
// ),
// ],
// ),
// ),
// ],
// ),
// const Spacer(),
// Container(
// width:
// AppVariables.appSize(context).width * 0.28,
// height:
// AppVariables.appSize(context).width * 0.27,
// decoration: BoxDecoration(
// image: const DecorationImage(
// image: AssetImage(AssetsManager.quranImage),
// opacity: 0.8,
// fit: BoxFit.cover,
// ),
// borderRadius: BorderRadius.circular(12),
// border: Border.all(color: MyColors.darkBrown),
// ),
// ),
// ],
// ),
// SizedBox(
// height: 5.h,
// ),
// //slider player
// if (isPlay == i + 1)
// SizedBox(
// width: AppVariables.appSize(context).width * 0.8,
// height:
// AppVariables.appSize(context).width * 0.05,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text(formatTime(position)),
// Expanded(
// child: Slider(
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
// ),
// Text(formatTime(duration)),
// ],
// ),
// ),
// ],
// ),
// ),
// ),
// ),
// ),
// separatorBuilder: (context, index) => SizedBox(height: 0.h),
// itemCount: 114,
// ),
// ),
