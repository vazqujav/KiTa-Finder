# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_kita_search_session',
  :secret      => 'ddb4157ae91f1d53a8b2a9479fb2751ae348756a0c107edf4ca8f9f5c4e3e6c68da6480c32594a793fa3b6e7fb178b34e888b23bf8373c0ac8a779b4f679e0c3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
