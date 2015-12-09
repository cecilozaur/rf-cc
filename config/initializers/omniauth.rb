Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '1e486a808313f1945436', '7af1da7cbf980a552d621424526475abe0f13b91', {
      client_options: {ssl: {:verify => false}}, #ssl verify peer has some issues with windows, this should not be used in production
      scope: 'user:email,user:follow'
  }
end
