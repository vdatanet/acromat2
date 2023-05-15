import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'albaranes_model.dart';
export 'albaranes_model.dart';

class AlbaranesWidget extends StatefulWidget {
  const AlbaranesWidget({
    Key? key,
    required this.filtro,
  }) : super(key: key);

  final String? filtro;

  @override
  _AlbaranesWidgetState createState() => _AlbaranesWidgetState();
}

class _AlbaranesWidgetState extends State<AlbaranesWidget> {
  late AlbaranesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AlbaranesModel());
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
            'ACs - ${widget.filtro}',
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
                          AcsGroup.acsCall
                              .call(
                            jwt: FFAppState().JWT,
                            empleado: FFAppState().Empleado,
                            take: FFAppState().Take,
                            skip: nextPageMarker.numItems,
                            filtro: widget.filtro,
                          )
                              .then((listViewAcsResponse) {
                            final pageItems = (getJsonField(
                                      listViewAcsResponse.jsonBody,
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
                                      lastResponse: listViewAcsResponse,
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
                              ListTile(
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
