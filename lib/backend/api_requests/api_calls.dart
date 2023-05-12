import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Root Group Code

class RootGroup {
  static String baseUrl = 'https://acromat.azurewebsites.net';
  static Map<String, String> headers = {};
  static LoginCall loginCall = LoginCall();
}

class LoginCall {
  Future<ApiCallResponse> call({
    String? username = '',
    String? password = '',
  }) {
    final body = '''
{
  "Username": "${username}",
  "Password": "${password}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Login',
      apiUrl: '${RootGroup.baseUrl}/login',
      callType: ApiCallType.POST,
      headers: {
        ...RootGroup.headers,
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

/// End Root Group Code

/// Start Menu Group Code

class MenuGroup {
  static String baseUrl = 'https://acromat.azurewebsites.net/menu';
  static Map<String, String> headers = {};
  static MenuCall menuCall = MenuCall();
  static OpcionesCall opcionesCall = OpcionesCall();
}

class MenuCall {
  Future<ApiCallResponse> call({
    String? jwt = '',
    String? grupoApp = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Menu',
      apiUrl: '${MenuGroup.baseUrl}/principal',
      callType: ApiCallType.GET,
      headers: {
        ...MenuGroup.headers,
        'Authorization': 'Bearer ${jwt}',
      },
      params: {
        'grupoApp': grupoApp,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class OpcionesCall {
  Future<ApiCallResponse> call({
    String? jwt = '',
    String? grupoApp = '',
    String? menuApp = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Opciones',
      apiUrl: '${MenuGroup.baseUrl}/opciones',
      callType: ApiCallType.GET,
      headers: {
        ...MenuGroup.headers,
        'Authorization': 'Bearer ${jwt}',
      },
      params: {
        'grupoApp': grupoApp,
        'menuApp': menuApp,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

/// End Menu Group Code

/// Start Filtro Group Code

class FiltroGroup {
  static String baseUrl = 'https://acromat.azurewebsites.net/filtro';
  static Map<String, String> headers = {};
  static PorTablaCall porTablaCall = PorTablaCall();
}

class PorTablaCall {
  Future<ApiCallResponse> call({
    String? jwt = '',
    String? tabla = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Por tabla',
      apiUrl: '${FiltroGroup.baseUrl}/portabla',
      callType: ApiCallType.GET,
      headers: {
        ...FiltroGroup.headers,
        'Authorization': 'Bearer ${jwt}',
      },
      params: {
        'tabla': tabla,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

/// End Filtro Group Code

/// Start Pts Group Code

class PtsGroup {
  static String baseUrl = 'https://acromat.azurewebsites.net/pts';
  static Map<String, String> headers = {};
  static PtsCall ptsCall = PtsCall();
}

class PtsCall {
  Future<ApiCallResponse> call({
    String? filtro = 'todos',
    int? skip = 5,
    int? take = 5,
    String? empleado = '4fea7cce-0faf-41c5-831c-c1026fa6a21b',
    String? jwt =
        'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImIzODAxNzJiLTYwZWEtNGQyYi05YWQ0LTVjN2M5MGQ0Mjc1ZSIsImp0aSI6ImFhZjlhZWNhLTBiMWYtNDU2NC1iNDQwLTg2YmZjNzM4YWE2ZiIsImV4cCI6MTg0MDk4MzYyMiwiaXNzIjoidmRhdGEubmV0IiwiYXVkIjoiYWNyb25ldCJ9.e5eQZqV74ExGi_AWWRIC0u8PhBs5DyN1Ldby1026rvi751KOzK1tAjU3Br0bLSASnpRETZq7fXnX_ir7w9aRWQ',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Pts',
      apiUrl: '${PtsGroup.baseUrl}/${filtro}',
      callType: ApiCallType.GET,
      headers: {
        ...PtsGroup.headers,
        'Authorization': 'Bearer ${jwt}',
      },
      params: {
        'empleado': empleado,
        'skip': skip,
        'take': take,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

/// End Pts Group Code

/// Start Pt Group Code

class PtGroup {
  static String baseUrl = 'https://acromat.azurewebsites.net/pt';
  static Map<String, String> headers = {};
  static CodigoCall codigoCall = CodigoCall();
}

class CodigoCall {
  Future<ApiCallResponse> call({
    String? jwt = '',
    String? idpt = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Codigo',
      apiUrl: '${PtGroup.baseUrl}/Codigo',
      callType: ApiCallType.GET,
      headers: {
        ...PtGroup.headers,
        'Authorization': 'Bearer ${jwt}',
      },
      params: {
        'idpt': idpt,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

/// End Pt Group Code

/// Start Cargar Group Code

class CargarGroup {
  static String baseUrl = 'https://acromat.azurewebsites.net/cargar';
  static Map<String, String> headers = {};
  static PTCargaMultipleDeFotosCall pTCargaMultipleDeFotosCall =
      PTCargaMultipleDeFotosCall();
  static PTCargaSimpleDeFotosCall pTCargaSimpleDeFotosCall =
      PTCargaSimpleDeFotosCall();
}

class PTCargaMultipleDeFotosCall {
  Future<ApiCallResponse> call({
    String? jwt = '',
    List<FFUploadedFile>? filesList,
    String? idpt = '',
    String? idempleado = '',
  }) {
    final files = filesList ?? [];

    return ApiManager.instance.makeApiCall(
      callName: 'PT Carga Multiple de Fotos',
      apiUrl: '${CargarGroup.baseUrl}/fotos/pt/${idpt}/${idempleado}',
      callType: ApiCallType.POST,
      headers: {
        ...CargarGroup.headers,
        'Authorization': 'Bearer ${jwt}',
      },
      params: {
        'files': files,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class PTCargaSimpleDeFotosCall {
  Future<ApiCallResponse> call({
    String? jwt = '',
    FFUploadedFile? file,
    String? idpt = '',
    String? idempleado = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'PT Carga Simple de Fotos',
      apiUrl: '${CargarGroup.baseUrl}/foto/pt/${idpt}/${idempleado}',
      callType: ApiCallType.POST,
      headers: {
        ...CargarGroup.headers,
        'Authorization': 'Bearer ${jwt}',
      },
      params: {
        'file': file,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

/// End Cargar Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar) {
  jsonVar ??= {};
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return '{}';
  }
}
