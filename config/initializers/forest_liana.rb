if Object.const_defined?('ForestLiana')
  ForestLiana.env_secret = Rails.application.secrets.forest_env_secret
  ForestLiana.auth_secret = Rails.application.secrets.forest_auth_secret
end
