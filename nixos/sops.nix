{
  sops.defaultSopsFile = ./../secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.secrets = {
    github_token = { };
  };
}
