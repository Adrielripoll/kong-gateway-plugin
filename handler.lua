-- my-jwt-decoder-plugin/kong/plugins/jwt-decoder/handler.lua

local jwt_decoder = require "kong.plugins.jwt.jwt_parser"

local JwtDecoderHandler = {
  PRIORITY = 1000,
  VERSION = "1.0.0"
}

function JwtDecoderHandler:access(conf)
  JwtDecoderHandler.super.access(self)

  local auth_header = kong.request.get_header("Authorization")
  if not auth_header then
    return kong.response.error(401, "Unauthorized: Missing Authorization header")
  end

  local token = auth_header:match("Bearer%s+(.+)")
  if not token then
    return kong.response.error(401, "Unauthorized: Missing Bearer token")
  end

  local jwt, err = jwt_decoder:new(token)
  if err then
    return kong.response.error(401, "Unauthorized: Invalid token")
  end

  local claims = jwt.claims
  for k, v in pairs(claims) do
    kong.service.request.set_header("X-User-" .. k, tostring(v))
  end
end

return JwtDecoderHandler
