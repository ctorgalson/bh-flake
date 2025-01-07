require("distant"):setup({
  client = {
    connect = {
      options = {
        username = "ctorgalson",
        identities_only = "yes",
        identity_files = {
          "/home/ctorgalson/.ssh/id_ed25519",
        },
      },
    },
  },
  manager = {
    log_file = "/home/ctorgalson/distant-manager.log",
    log_level = "trace",
    user = true,
  },
})
