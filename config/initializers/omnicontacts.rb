require "omnicontacts"
Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, ENV["GID"], ENV["GSECRET"], {:redirect_path => "/contacts/gmail/contact_callback"}
  importer :yahoo, "consumer_id", "consumer_secret", {:callback_path => "/callback"}
end