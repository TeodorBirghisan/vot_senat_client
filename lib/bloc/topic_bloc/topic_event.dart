import 'package:vot_senat_client/model/meeting.dart';
import 'package:vot_senat_client/model/topic.dart';

abstract class TopicEvent {
  const TopicEvent();
}

class TopicGetAll extends TopicEvent {
  final Meeting meeting;
  TopicGetAll(this.meeting);
}

class TopicCreate extends TopicEvent {
  final Meeting meeting;
  final Topic topic;
  TopicCreate(this.topic, this.meeting);
}
