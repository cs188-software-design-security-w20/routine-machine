import 'package:flutter/material.dart';
import 'package:routine_machine/api/APIWrapper.dart';
import './FollowTileInfo.dart';
import '../../constants/Palette.dart' as Palette;
import '../../Models/UserProfile.dart';

enum RequestStatus {
  pending,
  accepted,
  rejected,
}

class FollowerRequestTile extends StatefulWidget {
  final APIWrapper api = APIWrapper();
  final UserProfile userProfile;
  final Color color;
  final Function refreshFollowerList;

  FollowerRequestTile({this.userProfile, this.color, this.refreshFollowerList});

  @override
  _FollowerRequestTileState createState() => _FollowerRequestTileState();
}

class _FollowerRequestTileState extends State<FollowerRequestTile> {
  RequestStatus _status = RequestStatus.pending;

  _acceptRequest() {
    setState(() {
      _status = RequestStatus.accepted;
    });
    widget.api
        .approveFollowRequest(
      targetUserID: widget.userProfile.userID,
      targetUserPublicKey: widget.userProfile.publicKey,
    )
        .then((value) {
      Future.delayed(Duration(seconds: 1), () {
        widget.refreshFollowerList();
      });
    });
    print('Accepted request!');
  }

  _rejectRequest() {
    // TODO: properly implement this
    setState(() {
      _status = RequestStatus.rejected;
    });
    widget.api
        .rejectFollowRequest(targetUserID: widget.userProfile.userID)
        .then((value) {
      Future.delayed(Duration(seconds: 1), () {
        widget.refreshFollowerList();
      });
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
