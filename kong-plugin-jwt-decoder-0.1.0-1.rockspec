-- my-jwt-decoder-plugin/kong-plugin-jwt-decoder-0.1.0-1.rockspec

package = "kong-plugin-jwt-decoder"
version = "0.1.0-1"
source = {
  url = "file://."
}
description = {
  summary = "JWT Decoder plugin for Kong",
  detailed = "This plugin decodes JWT and injects the claims into the request headers",
  homepage = "https://example.com",
  license = "MIT"
}
dependencies = {
  "lua >= 5.1",
  "kong >= 2.0.0"
}
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.jwt-decoder.handler"] = "jwt-decoder/handler.lua",
    ["kong.plugins.jwt-decoder.schema"] = "jwt-decoder/schema.lua",
  }
}
