import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'partes_model.dart';
export 'partes_model.dart';

class PartesWidget extends StatefulWidget {
  const PartesWidget({
    Key? key,
    required this.filtro,
    required this.descripcion,
  }) : super(key: key);

  final String? filtro;
  final String? descripcion;

  @override
  _PartesWidgetState createState() => _PartesWidgetState();
}

class _PartesWidgetState extends State<PartesWidget> {
  late PartesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PartesModel());
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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'PTs - ${widget.descripcion}',
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
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() => _model.pagingController?.refresh());
                      await _model.waitForOnePage();
                    },
                    child: PagedListView<ApiPagingParams, dynamic>(
                      pagingController: () {
                        if (_model.pagingController != null) {
                          return _model.pagingController!;
                        }

                        _model.pagingController = PagingController(
                          firstPageKey: ApiPagingParams(
                            nextPageNumber: 0,
                            numItems: 0,
                            lastResponse: null,
                          ),
                        );
                        _model.pagingController!
                            .addPageRequestListener((nextPageMarker) {
                          PtsGroup.ptsCall
                              .call(
                            jwt: FFAppState().JWT,
                            empleado: FFAppState().Empleado,
                            filtro: widget.filtro,
                            take: FFAppState().Take,
                            skip: nextPageMarker.numItems,
                          )
                              .then((listViewPtsResponse) {
                            final pageItems = (getJsonField(
                                      listViewPtsResponse.jsonBody,
                                      r'''$''',
                                    ) ??
                                    [])
                                .toList() as List;
                            final newNumItems =
                                nextPageMarker.numItems + pageItems.length;
                            _model.pagingController!.appendPage(
                              pageItems,
                              (pageItems.length > 0)
                                  ? ApiPagingParams(
                                      nextPageNumber:
                                          nextPageMarker.nextPageNumber + 1,
                                      numItems: newNumItems,
                                      lastResponse: listViewPtsResponse,
                                    )
                                  : null,
                            );
                          });
                        });
                        return _model.pagingController!;
                      }(),
                      padding: EdgeInsets.zero,
                      reverse: false,
                      scrollDirection: Axis.vertical,
                      builderDelegate: PagedChildBuilderDelegate<dynamic>(
                        // Customize what your widget looks like when it's loading the first page.
                        firstPageProgressIndicatorBuilder: (_) => Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              color: FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),

                        itemBuilder: (context, _, itemsIndex) {
                          final itemsItem =
                              _model.pagingController!.itemList![itemsIndex];
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
                                    'Parte',
                                    queryParams: {
                                      'parte': serializeParam(
                                        getJsonField(
                                          itemsItem,
                                          r'''$.identificador''',
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
                                  subtitle: Text(
                                    getJsonField(
                                      itemsItem,
                                      r'''$.subtitulo''',
                                    ).toString(),
                                    style:
                                        FlutterFlowTheme.of(context).titleSmall,
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
                    ),
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
