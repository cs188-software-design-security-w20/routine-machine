import 'SampleFollowTileData.dart';
import '../constants/Palette.dart' as Palette;

// sample data to demo the check in list
//
final sampleCheckIns = <DateTime>[
  new DateTime.now(),
  new DateTime.utc(2021, 4, 20),
  new DateTime.utc(2020, 4, 30),
];

final List<SampleFollowTileData> sampleFollowingList = [
  SampleFollowTileData(
    firstName: 'Spencer',
    lastName: 'Jin',
    routineName: 'Workout',
    lastCheckIn: new DateTime.now(),
    color: Palette.pink,
  ),
  SampleFollowTileData(
    firstName: 'Lee',
    lastName: 'Jieun',
    routineName: 'Practice singing',
    lastCheckIn: new DateTime.now().subtract(new Duration(minutes: 15)),
    color: Palette.purple,
  ),
  SampleFollowTileData(
    firstName: 'Erika',
    lastName: 'Shen',
    routineName: 'Hike',
    lastCheckIn: new DateTime.now().subtract(new Duration(days: 1)),
    color: Palette.blue,
  ),
];
