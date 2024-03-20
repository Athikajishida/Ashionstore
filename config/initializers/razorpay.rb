require 'razorpay'

Razorpay.setup('rzp_test_ZCCSyrCe5ZqrEH','0jXHYc59iwAKVWDMphgnXlhu')
Razorpay.headers = { "CUSTOM_APP_HEADER" => "CUSTOM_VALUE" }
# key_id = Rails.application.credentials.dig(:razorpay, 'rzp_test_gL5Ocs7OvM45cH')
# secret_key = Rails.application.credentials.dig(:razorpay, 'N7mEFCZgC8AbaIud6UPItUUH')
# Razorpay.setup(key_id, secret_key)