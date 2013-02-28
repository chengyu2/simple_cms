# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
SimpleCms::Application.config.secret_token = '8ea53c2c4c3e6e3703c168b84390e297e633e2f90f89c72debfbc8b9f468faaad9ad17ffb7995c2a477ae6c2f9b77f21ef575336bb0620da951117f9dc83d1a0'


#rake secret ==> generate a new secret token to encrpt the session/cookie