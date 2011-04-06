# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_turcoWeb_session',
  :secret      => 'c0105408d198a3dd53ad0880c8794c48e3ee7c1232d1df73063dff94eb37762106fcb59d9812727fd167431d1e9632cc418ee05dc33d29db23f85f27a0c77997'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
