// ignore_for_file: public_member_api_docs, sort_constructors_first
enum EvidenceType { string, image, video, audio, file }

abstract class EvidenceModel {
  final String evidenceValue;
  final EvidenceType evidenceType;
  EvidenceModel({
    required this.evidenceValue,
    required this.evidenceType,
  });
}

class StringEvidenceModel extends EvidenceModel {
  StringEvidenceModel({
    required String evidenceValue,
  }) : super(
          evidenceValue: evidenceValue,
          evidenceType: EvidenceType.string,
        );
}

class ImageEvidenceModel extends EvidenceModel {
  ImageEvidenceModel({
    required String evidenceValue,
  }) : super(
          evidenceValue: evidenceValue,
          evidenceType: EvidenceType.image,
        );
}

class VideoEvidenceModel extends EvidenceModel {
  VideoEvidenceModel({
    required String evidenceValue,
  }) : super(
          evidenceValue: evidenceValue,
          evidenceType: EvidenceType.video,
        );
}

class AudioEvidenceModel extends EvidenceModel {
  AudioEvidenceModel({
    required String evidenceValue,
  }) : super(
          evidenceValue: evidenceValue,
          evidenceType: EvidenceType.audio,
        );
}

class FileEvidenceModel extends EvidenceModel {
  FileEvidenceModel({
    required String evidenceValue,
  }) : super(
          evidenceValue: evidenceValue,
          evidenceType: EvidenceType.file,
        );
}
