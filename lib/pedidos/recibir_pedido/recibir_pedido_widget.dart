import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'recibir_pedido_model.dart';
export 'recibir_pedido_model.dart';

class RecibirPedidoWidget extends StatefulWidget {
  const RecibirPedidoWidget({
    Key? key,
    required this.parte,
  }) : super(key: key);

  final String? parte;

  @override
  _RecibirPedidoWidgetState createState() => _RecibirPedidoWidgetState();
}

class _RecibirPedidoWidgetState extends State<RecibirPedidoWidget> {
  late RecibirPedidoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecibirPedidoModel());
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

    return FutureBuilder<ApiCallResponse>(
      future: PtGroup.codigoCall.call(
        jwt: FFAppState().JWT,
        idpt: widget.parte,
      ),
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
        final recibirPedidoCodigoResponse = snapshot.data!;
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            drawer: Drawer(
              elevation: 16.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Acciones',
                    style: FlutterFlowTheme.of(context).headlineLarge,
                  ),
                  Builder(
                    builder: (context) {
                      final acciones =
                          FFAppState().PtAcciones.map((e) => e).toList();
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: acciones.length,
                        itemBuilder: (context, accionesIndex) {
                          final accionesItem = acciones[accionesIndex];
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                'FotosPT',
                                queryParams: {
                                  'itpt': serializeParam(
                                    widget.parte,
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: ListTile(
                              title: Text(
                                accionesItem,
                                style:
                                    FlutterFlowTheme.of(context).headlineSmall,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: FlutterFlowTheme.of(context).accent2,
                                size: 20.0,
                              ),
                              tileColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              dense: false,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
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
                getJsonField(
                  recibirPedidoCodigoResponse.jsonBody,
                  r'''$.codigo''',
                ).toString(),
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
                      child: Builder(
                        builder: (context) {
                          final opciones =
                              FFAppState().PtOpciones.map((e) => e).toList();
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: opciones.length,
                            itemBuilder: (context, opcionesIndex) {
                              final opcionesItem = opciones[opcionesIndex];
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ListTile(
                                    title: Text(
                                      opcionesItem,
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
                                  Divider(
                                    height: 0.0,
                                    thickness: 1.0,
                                  ),
                                ],
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
      },
    );
  }
}
