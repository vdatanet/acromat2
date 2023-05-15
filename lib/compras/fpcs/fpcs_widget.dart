import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'fpcs_model.dart';
export 'fpcs_model.dart';

class FpcsWidget extends StatefulWidget {
  const FpcsWidget({Key? key}) : super(key: key);

  @override
  _FpcsWidgetState createState() => _FpcsWidgetState();
}

class _FpcsWidgetState extends State<FpcsWidget> {
  late FpcsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FpcsModel());
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
        drawer: Drawer(
          elevation: 16.0,
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.menu,
              color: FlutterFlowTheme.of(context).primaryBtnText,
              size: 30.0,
            ),
            onPressed: () async {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          title: Text(
            'Pedidos de Compra',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Roboto',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(),
                  child: FutureBuilder<ApiCallResponse>(
                    future: (_model.apiRequestCompleter ??=
                            Completer<ApiCallResponse>()
                              ..complete(FiltroGroup.porTablaCall.call(
                                jwt: FFAppState().JWT,
                                tabla: 'PC',
                              )))
                        .future,
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              color: FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        );
                      }
                      final listViewPorTablaResponse = snapshot.data!;
                      return Builder(
                        builder: (context) {
                          final items = getJsonField(
                            listViewPorTablaResponse.jsonBody,
                            r'''$''',
                          ).toList();
                          return RefreshIndicator(
                            onRefresh: () async {
                              setState(() => _model.apiRequestCompleter = null);
                              await _model.waitForApiRequestCompleted();
                            },
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: items.length,
                              itemBuilder: (context, itemsIndex) {
                                final itemsItem = items[itemsIndex];
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'Pedidos',
                                          queryParams: {
                                            'filtro': serializeParam(
                                              getJsonField(
                                                itemsItem,
                                                r'''$.titulo''',
                                              ).toString(),
                                              ParamType.String,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: ListTile(
                                        title: Text(
                                          getJsonField(
                                            itemsItem,
                                            r'''$.titulo''',
                                          ).toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .headlineSmall,
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF303030),
                                          size: 20.0,
                                        ),
                                        dense: false,
                                      ),
                                    ),
                                    Divider(
                                      height: 0.0,
                                      thickness: 1.0,
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
