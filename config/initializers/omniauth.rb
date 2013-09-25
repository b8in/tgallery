Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '166916236832271', '1396abfb1995dd2b319de0e251afa5b5'
end