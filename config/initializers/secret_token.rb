# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

secret = "9dd1cef234a2758fc76d3d0f9c2291a824dc74d49ec9caafeb8b7d9e3dadd13b2c59272dfabe8cf753b3e33ee813d268bd843bcde07635e075769f2e8f50608d"

Kidsart::Application.config.secret_token    = secret
Kidsart::Application.config.secret_key_base = secret
