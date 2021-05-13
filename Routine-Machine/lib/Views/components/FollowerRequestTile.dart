import 'package:flutter/material.dart';
import './FollowTileInfo.dart';
import '../../constants/Palette.dart' as Palette;
import '../../Models/UserProfile.dart';

enum RequestStatus {
  pending,
  accepted,
  rejected,
}

class FollowerRequestTile extends StatefulWidget {
  final UserProfile userProfile;
  final Color color;

  FollowerRequestTile({this.userProfile, this.color});

  @override
  _FollowerRequestTileState createState() => _FollowerRequestTileState();
}

class _FollowerRequestTileState extends State<FollowerRequestTile> {
  RequestStatus _status = RequestStatus.pending;

  _acceptRequest() {
    // TODO: properly implement this
    setState(() {
      _status = RequestStatus.accepted;
    });
    print('Accepted request!');
  }

  _rejectRequest() {
    // TODO: properly implement this
    setState(() {
      _status = RequestStatus.rejected;
    });
    print('Rejected request!');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          FollowTileInfo(
            firstName: this.widget.userProfile.username,
            lastName: '',
            caption: _status == RequestStatus.pending
                ? 'requests to follow you'
                : _status == RequestStatus.accepted
                    ? 'now follows you!'
                    : 'request has been rejected',
            color: this.widget.color,
          ),
          Container(
            child: _status == RequestStatus.pending
                ? Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.check_circle_outline_rounded),
                        color: Palette.darkGreen,
                        iconSize: 32,
                        onPressed: _acceptRequest,
                      ),
                      IconButton(
                        icon: Icon(Icons.highlight_off_rounded),
                        color: Palette.red,
                        iconSize: 32,
                        onPressed: _rejectRequest,
                      ),
                    ],
                  )
                : _status == RequestStatus.accepted
                    ? Text('accepted')
                    : Text('rejected'),
          ),
        ],
      ),
    );
  }
}
