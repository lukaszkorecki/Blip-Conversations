# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bconversation_session',
  :secret      => '8cba472e8e9f888935dc4affecbcf27aceec67ffcb76d00a2616b35b702e64c3d39bd6df729fcd4f8a84b3f79631247751a4c6c9ad13dc224920ce9845d5438f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
