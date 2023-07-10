import 'dart:io';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

// final _defaultImageAssetPath = join("asset", "images");
final _defaultImageAssetPath = join("images");//操作的目标图片路径
final _defaultOutputDir = join("lib", "res");//输出的目标路径
const _defaultFileName = "res_images.dart";

String get rootDirectoryPath => rootDirectory.path;

Directory get rootDirectory => Directory.current;

String imageAssetPath = _defaultImageAssetPath;
String outputDir = _defaultOutputDir;
String outputFile = _defaultFileName;

void main() {
  readConfig()
      .then((value) => createFile())
      .then((value) => writeContent(value));
}

Future readConfig() async {
  try {
    String yamlData = await File("my_tools.yaml").readAsString();
    var yaml = loadYaml(yamlData);
    imageAssetPath = yaml["imageAssetPath"] ?? _defaultImageAssetPath;
    outputDir = yaml["outputDir"] ?? _defaultOutputDir;
    outputFile = yaml["outputFile"] ?? _defaultFileName;
  } catch (e) {
    e.toString();
  }
}

Future<File> createFile() async {
  Directory target = Directory(join(rootDirectoryPath, outputDir));
  final bool targetDirExist = await target.exists();
  if (!targetDirExist) {
    await target.create(recursive: true);
  }
  File dartFile = File(join(target.path, outputFile));

  final bool fileExist = await dartFile.exists();

  if (!fileExist) {
    await dartFile.create();
  }

  return dartFile;
}

void writeContent(File file) {
  StringBuffer stringBuffer = StringBuffer();
  stringBuffer.writeln("/// Don't modify this file. It is auto generated.");
  stringBuffer.writeln(
      "/// to regenerate this file, please dart command-line with tools/image_res.dart");
  stringBuffer.writeln(
      "/// if you modified Asset files in $imageAssetPath Fold, please regenerate this file.");
  stringBuffer.writeln("class ImageRes {");
  stringBuffer.writeln();
  stringBuffer.writeln("  ImageRes._();");
  stringBuffer.writeln();
  Directory directory = Directory(join(rootDirectoryPath, imageAssetPath));

  directory.list().listen((event) {
    stringBuffer.writeln(convertFileNameToFiled(basename(event.path)));
    stringBuffer.writeln();
  }, onDone: () {
    stringBuffer.writeln("}");
    stringBuffer.writeln();
    stringBuffer.write('''extension AssetPathExtension on String {
  String get full => "$imageAssetPath/\$this";
}''');
    stringBuffer.writeln();
    file.writeAsString(stringBuffer.toString());
  });
}

String convertFileNameToFiled(String fileName) {
  StringBuffer sb = StringBuffer();
  sb.write("  static const String ");

  String extension = fileName.split('.').last.toUpperCase();
  List<String> nameSegments = fileName.split('.').first.split("_");
  for (int i = 0; i < nameSegments.length; i++) {
    String seg = nameSegments[i];
    if (i == 0) {
      if (startWithNumber(seg)) {
        seg = "\$$seg";
      }
      sb.write(seg);
    } else {
      sb.write(seg.substring(0, 1).toUpperCase());
      sb.write(seg.substring(1));
    }
  }
  sb.write(extension.toUpperCase());

  sb.write(" = '");
  sb.write(fileName);
  sb.write("';");

  return sb.toString();
}

bool startWithNumber(String source) {
  if (source.isNotEmpty) {
    List<int> ss = source.codeUnits;
    return ss.first >= 48 && ss.first <= 57;
  }
  return false;
}
