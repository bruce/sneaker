class SneakerApiMock

  @has_response: (name, fn) ->
    Sneaker.util.type name, 'string', '@response expects `name` to be a string'
    Sneaker.util.type fn, 'function', '@response expects the second argument to be a function'

    responses = Sneaker.convention.responsesName()
    (@::[responses] = (@::[responses] || []).slice 0).push name
    @::[Sneaker.convention.responseName name] = fn

  respond: (mockedResponse = {}) ->
    status = mockedResponse.status ||= 200
    mockedResponse.body ||= null

    statusCodes =
      100: "Continue",
      101: "Switching Protocols",
      200: "OK",
      201: "Created",
      202: "Accepted",
      203: "Non-Authoritative Information",
      204: "No Content",
      205: "Reset Content",
      206: "Partial Content",
      300: "Multiple Choice",
      301: "Moved Permanently",
      302: "Found",
      303: "See Other",
      304: "Not Modified",
      305: "Use Proxy",
      307: "Temporary Redirect",
      400: "Bad Request",
      401: "Unauthorized",
      402: "Payment Required",
      403: "Forbidden",
      404: "Not Found",
      405: "Method Not Allowed",
      406: "Not Acceptable",
      407: "Proxy Authentication Required",
      408: "Request Timeout",
      409: "Conflict",
      410: "Gone",
      411: "Length Required",
      412: "Precondition Failed",
      413: "Request Entity Too Large",
      414: "Request-URI Too Long",
      415: "Unsupported Media Type",
      416: "Requested Range Not Satisfiable",
      417: "Expectation Failed",
      422: "Unprocessable Entity",
      500: "Internal Server Error",
      501: "Not Implemented",
      502: "Bad Gateway",
      503: "Service Unavailable",
      504: "Gateway Timeout",
      505: "HTTP Version Not Supported"

    if ( status >= 200 and status < 300 ) or status is 304 or status is 1223 or status is 0
      jQuery.Deferred().resolveWith this, [mockedResponse.body, statusCodes[status], {}]
    else
      jQuery.Deferred().rejectWith this, [{}, statusCodes[status], new Error statusCodes[status]]

Sneaker.ns.set this, 'Sneaker.ApiMock', SneakerApiMock