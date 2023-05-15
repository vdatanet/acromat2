import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'fotos_p_t_model.dart';
export 'fotos_p_t_model.dart';

class FotosPTWidget extends StatefulWidget {
  const FotosPTWidget({
    Key? key,
    required this.itpt,
  }) : super(key: key);

  final String? itpt;

  @override
  _FotosPTWidgetState createState() => _FotosPTWidgetState();
}

class _FotosPTWidgetState extends State<FotosPTWidget> {
  late FotosPTModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FotosPTModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            '',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Roboto',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: [
            FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.folder_outlined,
                color: FlutterFlowTheme.of(context).primaryBtnText,
                size: 30.0,
              ),
              onPressed: () async {
                final selectedMedia = await selectMedia(
                  maxWidth: 1280.00,
                  imageQuality: 75,
                  includeDimensions: true,
                  mediaSource: MediaSource.photoGallery,
                  multiImage: true,
                );
                if (selectedMedia != null &&
                    selectedMedia.every(
                        (m) => validateFileFormat(m.storagePath, context))) {
                  setState(() => _model.isDataUploading1 = true);
                  var selectedUploadedFiles = <FFUploadedFile>[];

                  try {
                    selectedUploadedFiles = selectedMedia
                        .map((m) => FFUploadedFile(
                              name: m.storagePath.split('/').last,
                              bytes: m.bytes,
                              height: m.dimensions?.height,
                              width: m.dimensions?.width,
                              blurHash: m.blurHash,
                            ))
                        .toList();
                  } finally {
                    _model.isDataUploading1 = false;
                  }
                  if (selectedUploadedFiles.length == selectedMedia.length) {
                    setState(() {
                      _model.uploadedLocalFiles1 = selectedUploadedFiles;
                    });
                  } else {
                    setState(() {});
                    return;
                  }
                }

                _model.apiResultvi0 =
                    await CargarGroup.pTCargaMultipleDeFotosCall.call(
                  jwt: FFAppState().JWT,
                  filesList: _model.uploadedLocalFiles1,
                  idpt: widget.itpt,
                  idempleado: FFAppState().Empleado,
                );
                if (!(_model.apiResultvi0?.succeeded ?? true)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Error de carga',
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      duration: Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                    ),
                  );
                }

                setState(() {});
              },
            ),
            FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.photo_camera,
                color: FlutterFlowTheme.of(context).primaryBtnText,
                size: 30.0,
              ),
              onPressed: () async {
                final selectedMedia = await selectMedia(
                  maxWidth: 1280.00,
                  imageQuality: 75,
                  multiImage: false,
                );
                if (selectedMedia != null &&
                    selectedMedia.every(
                        (m) => validateFileFormat(m.storagePath, context))) {
                  setState(() => _model.isDataUploading2 = true);
                  var selectedUploadedFiles = <FFUploadedFile>[];

                  try {
                    selectedUploadedFiles = selectedMedia
                        .map((m) => FFUploadedFile(
                              name: m.storagePath.split('/').last,
                              bytes: m.bytes,
                              height: m.dimensions?.height,
                              width: m.dimensions?.width,
                              blurHash: m.blurHash,
                            ))
                        .toList();
                  } finally {
                    _model.isDataUploading2 = false;
                  }
                  if (selectedUploadedFiles.length == selectedMedia.length) {
                    setState(() {
                      _model.uploadedLocalFile2 = selectedUploadedFiles.first;
                    });
                  } else {
                    setState(() {});
                    return;
                  }
                }

                _model.apiResultjiz =
                    await CargarGroup.pTCargaSimpleDeFotosCall.call(
                  jwt: FFAppState().JWT,
                  idempleado: FFAppState().Empleado,
                  idpt: widget.itpt,
                  file: _model.uploadedLocalFile2,
                );
                if (!(_model.apiResultjiz?.succeeded ?? true)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Error en la carga',
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      duration: Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                    ),
                  );
                }

                setState(() {});
              },
            ),
          ],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [],
          ),
        ),
      ),
    );
  }
}
