import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:vot_senat_client/model/topic.dart';
import 'package:vot_senat_client/service/topic_service.dart';

import 'topic_event.dart';
import 'topic_state.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState> {
  TopicBloc() : super(TopicInit()) {
    on<TopicGetAll>(_onGetAll);
    on<TopicCreate>(_onCreate);
    on<TopicDelete>(_onDelete);
  }

  FutureOr<void> _onGetAll(TopicGetAll event, Emitter<TopicState> emit) async {
    emit(TopicGetAllLoading());

    Response response = await TopicService.instance.getAll(event.meeting);

    if (response.statusCode == HttpStatus.ok) {
      List<Topic> data = TopicService.instance.deserializeAll(response);
      emit(TopicGetAllSuccess(data));
    } else {
      emit(TopicGetAllError());
    }
  }

  FutureOr<void> _onCreate(TopicCreate event, Emitter<TopicState> emit) async {
    emit(TopicCreateLoading());

    Response response = await TopicService.instance.create(event.topic, event.meeting);

    if (response.statusCode == HttpStatus.created) {
      Topic data = TopicService.instance.deserializeOne(response);
      emit(TopicCreateSuccess(data));
    } else {
      emit(TopicGetAllError());
    }
  }

  FutureOr<void> _onDelete(TopicDelete event, Emitter<TopicState> emit) async {
    emit(TopicDeleteLoading());

    Response response = await TopicService.instance.deleteOne(event.topicId, event.meetingId);

    if (response.statusCode == HttpStatus.ok) {
      int? data = TopicService.instance.deserializeId(response);
      emit(TopicDeleteSuccess(data));
    } else {
      emit(TopicDeleteError());
    }
  }
}
