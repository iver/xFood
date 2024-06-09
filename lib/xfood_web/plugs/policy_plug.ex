defmodule XfoodWeb.PolicyPlug do
  @moduledoc false
  import Plug.Conn

  @headers [
    # https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Referrer-Policy
    {"referrer-policy", "strict-origin-when-cross-origin"},
    {"x-content-type-options", "nosniff"},
    # Se aplica solo a Internet Explorer, se puede eliminar de forma segura en el futuro.
    {"x-download-options", "noopen"},
    {"x-frame-options", "SAMEORIGIN"},
    {"x-permitted-cross-domain-policies", "none"}
  ]

  def init(opts) do
    opts
  end

  def call(conn, %{env: env, host: host}) do
    csp_nonce = generate_nonce()
    directives = build_directives(env, host, csp_nonce)

    conn
    |> put_secure_browser_headers(directives)
    |> assign(:csp_nonce, csp_nonce)
  end

  def put_secure_browser_headers(conn, headers \\ %{})

  def put_secure_browser_headers(conn, []) do
    put_secure_defaults(conn)
  end

  def put_secure_browser_headers(conn, headers) when is_binary(headers) do
    conn
    |> put_secure_defaults()
    |> merge_resp_headers(%{"content-security-policy" => headers})
  end

  defp put_secure_defaults(conn) do
    merge_resp_headers(conn, @headers)
  end

  def build_directives(:prod, host, nonce) do
    [
      "child-src blob:",
      "connect-src 'self' #{get_endpoint(:ws, host)} #{connect_src_directive()}",
      "default-src 'none'",
      "font-src 'self' #{get_endpoint(:http, host)}",
      "form-action 'self'",
      "frame-ancestors 'self'",
      "frame-src 'self'",
      "img-src 'self' #{add_nonce(nonce)} data: blob: ",
      "media-src 'self' #{get_endpoint(:http, host)}",
      "script-src 'unsafe-eval' 'self' #{add_nonce(nonce)} #{connect_src_directive()}",
      "style-src 'unsafe-inline' 'self' #{connect_src_directive()}",
      "worker-src blob:"
    ]
    |> Enum.join("; ")
  end

  def build_directives(_env, host, nonce) do
    [
      "connect-src ws://#{host}:* #{connect_src_directive()}",
      "default-src 'self' 'unsafe-eval' 'unsafe-inline'",
      "font-src 'self' data:",
      "img-src 'self' blob: data:",
      "script-src 'unsafe-inline' 'unsafe-eval' 'self' #{add_nonce(nonce)} #{connect_src_directive()}",
      "style-src 'unsafe-inline' 'self' #{connect_src_directive()}"
    ]
    |> Enum.join("; ")
  end

  defp add_nonce(nonce) do
    "'nonce-#{nonce}'"
  end

  defp get_endpoint(:ws, host) do
    alias XfoodWeb.Endpoint

    %URI{scheme: scheme, port: _port} = Endpoint.struct_url()
    scheme_to_ws = String.replace(scheme, "http", "ws")
    "#{scheme_to_ws}://#{host}:*"
  end

  defp get_endpoint(:http, host) do
    alias XfoodWeb.Endpoint

    %URI{scheme: scheme} = Endpoint.struct_url()
    "#{scheme}://#{host}"
  end

  defp connect_src_directive do
    "https://cdnjs.cloudflare.com"
  end

  def generate_nonce do
    :md5
    |> :crypto.hash(random_string())
    |> Base.encode16()
  end

  def random_string(length \\ 32) do
    length
    |> :crypto.strong_rand_bytes()
    |> Base.encode64(padding: false)
    |> binary_part(0, length)
  end
end
