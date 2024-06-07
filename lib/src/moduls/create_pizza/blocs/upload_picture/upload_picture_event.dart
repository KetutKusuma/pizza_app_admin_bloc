// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'upload_picture_bloc.dart';

sealed class UploadPictureEvent extends Equatable {
  const UploadPictureEvent();

  @override
  List<Object> get props => [];
}

class UploadPicture extends UploadPictureEvent {
  final Uint8List file;
  final String name;

  const UploadPicture(
    this.file,
    this.name,
  );

  @override
  List<Object> get props => [file, name];
}
