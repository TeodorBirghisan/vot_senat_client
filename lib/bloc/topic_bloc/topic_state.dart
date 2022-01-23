import 'package:vot_senat_client/model/topic.dart';

abstract class TopicState {
  const TopicState();
}

class TopicInit extends TopicState {}

abstract class TopicLoading extends TopicState {}

abstract class TopicSuccess extends TopicState {}

abstract class TopicError extends TopicState {}

class TopicGetAllLoading extends TopicLoading {}

class TopicGetAllSuccess extends TopicSuccess {
  final List<Topic> data;
  TopicGetAllSuccess(this.data);
}

class TopicGetAllError extends TopicError {}

class TopicCreateLoading extends TopicLoading {}

class TopicCreateSuccess extends TopicSuccess {
  final Topic data;
  TopicCreateSuccess(this.data);
}

class TopicCreateError extends TopicError {}
