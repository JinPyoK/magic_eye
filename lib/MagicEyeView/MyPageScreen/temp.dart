import 'package:flutter/material.dart';
import 'package:magic_eye/Firebase/database.dart';

class TempButton extends StatelessWidget {
  const TempButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          await updateDB({
            'people_count': {
              // 2020년
              '2020-01-01 00:00:00': {'people_count': 13500},
              '2020-03-05 00:00:00': {'people_count': 17900},
              '2020-12-30 00:00:00': {'people_count': 20000},
              // 2021년
              '2021-07-30 00:00:00': {'people_count': 20000},
              '2021-09-30 00:00:00': {'people_count': 30000},
              '2021-11-30 00:00:00': {'people_count': 5000},
              // 2022년
              '2022-11-30 00:00:00': {'people_count': 12500},
              '2022-03-30 00:00:00': {'people_count': 5000},
              '2022-07-30 00:00:00': {'people_count': 7390},
              // 2023년 월별
              '2023-01-30 00:00:00': {'people_count': 800},
              '2023-02-30 00:00:00': {'people_count': 900},
              '2023-03-30 00:00:00': {'people_count': 1200},
              '2023-04-30 00:00:00': {'people_count': 1500},
              '2023-05-30 00:00:00': {'people_count': 800},
              '2023-06-30 00:00:00': {'people_count': 700},
              '2023-07-30 00:00:00': {'people_count': 350},
              '2023-08-30 00:00:00': {'people_count': 480},
              '2023-09-30 00:00:00': {'people_count': 850},
              '2023-10-30 00:00:00': {'people_count': 900},
              '2023-11-30 00:00:00': {'people_count': 910},
              // 2023년 일별
              '2023-12-01 00:00:00': {'people_count': 28},
              '2023-12-02 00:00:00': {'people_count': 16},
              '2023-12-03 00:00:00': {'people_count': 5},
              '2023-12-04 00:00:00': {'people_count': 23},
              '2023-12-05 00:00:00': {'people_count': 15},
              '2023-12-06 00:00:00': {'people_count': 14},
              '2023-12-07 00:00:00': {'people_count': 26},
              '2023-12-08 00:00:00': {'people_count': 31},
              '2023-12-09 00:00:00': {'people_count': 38},
              // 2023년 시간별
              '2023-12-10 00:00:00': {'people_count': 1},
              '2023-12-10 01:00:00': {'people_count': 3},
              '2023-12-10 03:00:00': {'people_count': 2},
              '2023-12-10 04:00:00': {'people_count': 1},
              '2023-12-10 05:00:00': {'people_count': 1},
              '2023-12-10 06:00:00': {'people_count': 2},
              '2023-12-10 08:00:00': {'people_count': 1},
              '2023-12-10 10:00:00': {'people_count': 6},
              '2023-12-10 12:00:00': {'people_count': 8},
              '2023-12-10 14:00:00': {'people_count': 6},
              '2023-12-10 15:00:00': {'people_count': 12},
            },
          });
        },
        child: const Text("정보저장"));
  }
}

// {
// 'anormals': [
// {
// 'date': "2023-09-18 09:45",
// 'cam': "cam1",
// 'type': 'occupy',
// 'videoURL': 'videoURL1'
// },
// {
// 'date': "2023-05-23 17:12",
// 'cam': "cam1",
// 'type': 'theft',
// 'videoURL': 'videoURL2'
// },
// {
// 'date': "2022-07-02 15:36",
// 'cam': "cam2",
// 'type': 'break',
// 'videoURL': 'videoURL3'
// },
// {
// 'date': "2022-07-09 05:36",
// 'cam': "cam1",
// 'type': 'occupy',
// 'videoURL': 'videoURL3'
// },
// {
// 'date': "2022-04-01 13:36",
// 'cam': "cam2",
// 'type': 'occupy',
// 'videoURL': 'videoURL3'
// },
// {
// 'date': "2022-07-02 18:36",
// 'cam': "cam2",
// 'type': 'break',
// 'videoURL': 'videoURL3'
// },
// ]
// }

// 'people_info': {
// '2023-12-09 07:20:39': {'age': 6, 'gender': 'Man'},
// '2023-12-08 07:20:39': {'age': 6, 'gender': 'Man'},
// '2023-12-07 07:20:39': {'age': 6, 'gender': 'Man'},
// '2023-12-17 07:20:39': {'age': 6, 'gender': 'Man'},
// '2023-12-09 07:20:40': {'age': 12, 'gender': 'Man'},
// '2023-12-09 07:20:41': {'age': 15, 'gender': 'Man'},
// '2023-12-09 07:20:32': {'age': 17, 'gender': 'Man'},
// '2023-12-09 07:20:33': {'age': 20, 'gender': 'Man'},
// '2023-12-09 07:20:34': {'age': 21, 'gender': 'Man'},
// '2023-12-09 07:20:35': {'age': 22, 'gender': 'Man'},
// '2023-12-09 07:20:36': {'age': 23, 'gender': 'Man'},
// '2023-12-09 07:20:37': {'age': 24, 'gender': 'Man'},
// '2023-12-09 07:10:37': {'age': 24, 'gender': 'Man'},
// '2023-12-09 07:30:37': {'age': 24, 'gender': 'Man'},
// '2023-12-09 07:40:37': {'age': 24, 'gender': 'Man'},
// '2023-12-09 07:50:37': {'age': 24, 'gender': 'Man'},
// '2023-12-09 07:26:37': {'age': 24, 'gender': 'Man'},
// '2023-12-09 07:20:38': {'age': 25, 'gender': 'Man'},
// '2023-12-09 07:20:12': {'age': 26, 'gender': 'Man'},
// '2023-12-09 07:20:23': {'age': 27, 'gender': 'Man'},
// '2023-12-09 07:10:23': {'age': 28, 'gender': 'Man'},
// '2023-12-09 07:22:23': {'age': 30, 'gender': 'Man'},
// '2023-12-09 07:30:23': {'age': 31, 'gender': 'Man'},
// '2023-12-09 07:40:23': {'age': 32, 'gender': 'Man'},
// '2023-12-09 07:50:23': {'age': 33, 'gender': 'Man'},
// '2022-12-09 07:50:23': {'age': 33, 'gender': 'Man'},
// '2022-02-09 07:50:23': {'age': 33, 'gender': 'Man'},
// '2022-05-09 07:50:23': {'age': 33, 'gender': 'Man'},
// '2022-08-09 07:50:23': {'age': 33, 'gender': 'Man'},
// '2022-07-09 07:50:23': {'age': 33, 'gender': 'Man'},
// '2022-09-09 07:50:23': {'age': 33, 'gender': 'Man'},
// '2022-11-09 07:50:23': {'age': 33, 'gender': 'Man'},
// '2023-12-09 07:23:23': {'age': 34, 'gender': 'Man'},
// '2023-12-09 01:23:23': {'age': 35, 'gender': 'Man'},
// '2023-12-09 02:23:23': {'age': 36, 'gender': 'Man'},
// '2023-12-09 03:23:23': {'age': 37, 'gender': 'Man'},
// '2023-12-09 04:23:23': {'age': 38, 'gender': 'Man'},
// '2023-12-09 05:23:23': {'age': 39, 'gender': 'Man'},
// '2023-12-09 06:23:23': {'age': 40, 'gender': 'Man'},
// '2023-12-09 02:43:23': {'age': 41, 'gender': 'Man'},
// '2023-12-09 08:23:23': {'age': 42, 'gender': 'Man'},
// '2023-12-09 09:23:23': {'age': 43, 'gender': 'Man'},
// '2023-12-09 12:23:23': {'age': 44, 'gender': 'Man'},
// '2023-12-09 13:23:23': {'age': 45, 'gender': 'Man'},
// '2023-12-09 14:23:23': {'age': 61, 'gender': 'Man'},
// '2023-12-09 15:23:23': {'age': 62, 'gender': 'Man'},
// '2023-12-09 16:23:23': {'age': 63, 'gender': 'Man'},
// '2023-12-09 17:23:23': {'age': 64, 'gender': 'Man'},
// '2023-12-09 18:23:23': {'age': 65, 'gender': 'Man'},
// '2023-12-09 19:23:23': {'age': 60, 'gender': 'Man'},
// '2022-12-09 07:20:39': {'age': 6, 'gender': 'Woman'},
// '2022-12-09 07:20:40': {'age': 12, 'gender': 'Woman'},
// '2022-12-09 07:20:41': {'age': 15, 'gender': 'Woman'},
// '2022-12-09 07:20:32': {'age': 17, 'gender': 'Woman'},
// '2022-12-09 07:20:33': {'age': 20, 'gender': 'Woman'},
// '2022-12-09 07:20:34': {'age': 21, 'gender': 'Woman'},
// '2022-12-09 07:20:35': {'age': 22, 'gender': 'Woman'},
// '2022-12-09 07:20:36': {'age': 23, 'gender': 'Woman'},
// '2022-12-09 07:20:37': {'age': 24, 'gender': 'Woman'},
// '2022-12-09 07:20:38': {'age': 25, 'gender': 'Woman'},
// '2022-12-09 07:20:12': {'age': 26, 'gender': 'Woman'},
// '2022-12-09 07:20:23': {'age': 27, 'gender': 'Woman'},
// '2022-12-09 07:10:23': {'age': 28, 'gender': 'Woman'},
// '2022-12-09 07:30:23': {'age': 20, 'gender': 'Woman'},
// '2022-12-09 07:40:23': {'age': 21, 'gender': 'Woman'},
// '2022-12-09 07:50:23': {'age': 22, 'gender': 'Woman'},
// '2022-12-09 07:23:23': {'age': 23, 'gender': 'Woman'},
// '2022-12-09 07:22:23': {'age': 24, 'gender': 'Woman'},
// '2022-12-09 01:23:23': {'age': 25, 'gender': 'Woman'},
// '2022-12-09 02:23:23': {'age': 36, 'gender': 'Woman'},
// '2022-12-09 03:23:23': {'age': 37, 'gender': 'Woman'},
// '2022-12-09 04:23:23': {'age': 38, 'gender': 'Woman'},
// '2022-12-09 05:23:23': {'age': 39, 'gender': 'Woman'},
// '2022-12-09 06:23:23': {'age': 40, 'gender': 'Woman'},
// '2022-12-09 02:43:23': {'age': 41, 'gender': 'Woman'},
// '2022-12-09 08:23:23': {'age': 42, 'gender': 'Woman'},
// '2022-12-09 09:23:23': {'age': 43, 'gender': 'Woman'},
// '2022-12-09 12:23:23': {'age': 44, 'gender': 'Woman'},
// '2022-12-09 13:23:23': {'age': 45, 'gender': 'Woman'},
// '2022-12-09 14:23:23': {'age': 21, 'gender': 'Woman'},
// '2022-12-09 15:23:23': {'age': 22, 'gender': 'Woman'},
// '2022-12-09 16:23:23': {'age': 10, 'gender': 'Woman'},
// '2022-12-09 17:23:23': {'age': 81, 'gender': 'Woman'},
// '2022-12-09 18:23:23': {'age': 65, 'gender': 'Woman'},
// '2022-12-09 19:23:23': {'age': 60, 'gender': 'Woman'},
// '2022-12-08 09:23:23': {'age': 43, 'gender': 'Woman'},
// '2022-12-07 09:23:23': {'age': 43, 'gender': 'Woman'},
// '2022-12-06 09:23:23': {'age': 43, 'gender': 'Woman'},
// '2022-12-05 09:23:23': {'age': 43, 'gender': 'Woman'},
// '2022-12-04 09:23:23': {'age': 43, 'gender': 'Woman'},
// '2022-12-03 09:23:23': {'age': 43, 'gender': 'Woman'},
// '2022-12-02 09:23:23': {'age': 43, 'gender': 'Woman'},
// '2022-12-01 09:23:23': {'age': 43, 'gender': 'Woman'},
// }
