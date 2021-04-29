import 'package:flutter/material.dart';

// NOTE: this is just a sample class to demo the following tile list
// we will not actually use this class in our app
class SampleFollowTileData {
  final String firstName;
  final String lastName;
  final String routineName;
  final DateTime lastCheckIn;
  final Color
      color; // Question: will users have their own color or should we randomize this?
  SampleFollowTileData({
    this.firstName,
    this.lastName,
    this.routineName,
    this.lastCheckIn,
    this.color,
  });
}
