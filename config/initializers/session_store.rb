# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_repo_session',
  :secret      => '8590f62eafc9559be9889e6e654f2ad7e4aa879ca7716b574bf5db905004b390e1202c238a7d5867676ad7ed00bab8ed169a7be9a5a47bcf6a46484c600e02e4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
