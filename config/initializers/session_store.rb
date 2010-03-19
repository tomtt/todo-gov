# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_todo-gov_session',
  :secret      => '172732f5d2227789243a1a563fcfccc22882ec62378175dd05cb833f9503b0b820f5dfcf2c3e5336960a42192626e5605be6b3c2a88c06ac8e3b24649ef1af0d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
