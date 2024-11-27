/// ### Credit:
/// 
/// Adapted from the work of OpenAI"s ChatGPT, created by OpenAI.
/// 
/// @see {@link https://www.openai.com/}
/// 
/// @see {@link https://platform.openai.com/docs/api-reference/introduction}
///
/// Original implementation: OpenAI"s ChatGPT
enum HttpStatusCode {
  // Informational Responses
  continueCode(100, 'Continue'),
  switchingProtocols(101, 'Switching Protocols'),
  processing(102, 'Processing'),

  // Success Responses
  ok(200, 'OK'),
  created(201, 'Created'),
  accepted(202, 'Accepted'),
  nonAuthoritativeInformation(203, 'Non-Authoritative Information'),
  noContent(204, 'No Content'),
  resetContent(205, 'Reset Content'),
  partialContent(206, 'Partial Content'),

  // Redirection Responses
  multipleChoices(300, 'Multiple Choices'),
  movedPermanently(301, 'Moved Permanently'),
  found(302, 'Found'),
  seeOther(303, 'See Other'),
  notModified(304, 'Not Modified'),
  temporaryRedirect(307, 'Temporary Redirect'),
  permanentRedirect(308, 'Permanent Redirect'),

  // Client Error Responses
  badRequest(400, 'Bad Request'),
  unauthorized(401, 'Unauthorized'),
  paymentRequired(402, 'Payment Required'),
  forbidden(403, 'Forbidden'),
  notFound(404, 'Not Found'),
  methodNotAllowed(405, 'Method Not Allowed'),
  notAcceptable(406, 'Not Acceptable'),
  requestTimeout(408, 'Request Timeout'),
  conflict(409, 'Conflict'),
  gone(410, 'Gone'),
  lengthRequired(411, 'Length Required'),
  payloadTooLarge(413, 'Payload Too Large'),
  uriTooLong(414, 'URI Too Long'),
  unsupportedMediaType(415, 'Unsupported Media Type'),
  unprocessableEntity(422, 'Unprocessable Entity'),

  // Server Error Responses
  internalServerError(500, 'Internal Server Error'),
  notImplemented(501, 'Not Implemented'),
  badGateway(502, 'Bad Gateway'),
  serviceUnavailable(503, 'Service Unavailable'),
  gatewayTimeout(504, 'Gateway Timeout');

  final int code;
  final String description;

  const HttpStatusCode(this.code, this.description);

  /// Returns the enum for the given HTTP code, or null if not found.
  static HttpStatusCode? fromCode(int code) {
    return HttpStatusCode.values.firstWhere(
      (e) => e.code == code,
      orElse: () => HttpStatusCode.internalServerError,
    );
  }

  @override
  String toString() => '$code $description';
}