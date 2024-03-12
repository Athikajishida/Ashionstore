require 'razorpay'

  Razorpay.setup(ENV['yrzp_test_ZCCSyrCe5ZqrEH'], ENV['0jXHYc59iwAKVWDMphgnXlhu'])
# Set custom headers for Razorpay requests
Razorpay.headers = { "CUSTOM_APP_HEADER" => "CUSTOM_VALUE" }