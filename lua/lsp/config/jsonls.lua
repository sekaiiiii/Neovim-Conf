local opts = {
  on_attach = function(client, bufnr)
  end,
}

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
