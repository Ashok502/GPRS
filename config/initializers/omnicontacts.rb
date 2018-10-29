require "omnicontacts"
Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, "399845174723-200dcmtl85b06n1dmb4cbh1vmkcjmbeg.apps.googleusercontent.com", "r5rniUt3Sj_b-TU3C9dPAe8q", {:redirect_path => "/contacts/gmail/contact_callback"}
  # importer :yahoo, "consumer_id", "consumer_secret", {:callback_path => "/callback"}
end