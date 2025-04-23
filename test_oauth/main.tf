terraform {
    required_providers {
        terracurl = {
        source  = "devops-rob/terracurl"
        }
    }
    
    required_version = ">= 1.0.0"
}

# provider "terracurl" {
#   # No configuration required here
# }



data "terracurl_request" "test" {
  name = "token"
  url    = "https://oauth.e4t1w3t5o7q5r6j.v9wp.p3.openshiftapps.com:443/oauth/authorize?client_id=openshift-challenging-client&response_type=token"
  method = "GET"
  skip_tls_verify = true
  headers = {
    "Authorization" = "Basic ${local.oauth_cred}",
    "Content-Type" = "application/x-www-form-urlencoded",
    "X-CSRF-Token" = "xxx",
    "User-Agent" = "curl/8.7.1"
  }

  response_codes = [
    200, 302, 307
  ]

  max_retry      = 1
  retry_interval = 2
}

output "response" {
  value = jsondecode(data.terracurl_request.test.response)
}

# terraform {
#   required_providers {
#     restapi = {
#       source = "Mastercard/restapi"
#       version = "2.0.1"
#     }
#   }
# }




# provider "restapi" {
#   uri                  = "https://oauth.e4t1w3t5o7q5r6j.v9wp.p3.openshiftapps.com"
#   write_returns_object = false
#   debug                = true
#   insecure = true

#   headers = {
#     "Authorization" = "Basic ${local.oauth_cred}",
#     "X-CSRF-Token" = "xxx",
#     "Content-Type" = "application/x-www-form-urlencoded",
#     "Content-Type"  = "application/x-www-form-urlencoded",
#   }

#   create_method  = "PUT"
#   update_method  = "PUT"
#   destroy_method = "PUT"
# }

# data "restapi_object" "John" {
#   path = "/oauth/authorize?client_id=openshift-challenging-client&response_type=token"
#   search_key = ""
#   search_value = ""
# }


locals {
  oauth_cred = base64encode("cluster-admin:")
}

# data "http" "openshift_auth" {
#   depends_on = [ local.oauth_cred ]
#   url = "https://oauth.e4t1w3t5o7q5r6j.v9wp.p3.openshiftapps.com/oauth/authorize?client_id=openshift-challenging-client&response_type=token"
#   insecure = true
  


#   # base64 encoded
#   request_headers = {
#     Authorization = "Basic ${local.oauth_cred}"
#     X-CSRF-Token = "xxx"
#     Content-Type  = "application/x-www-form-urlencoded"
#   }
# }


# output "headers" {
#   value = data.http.openshift_auth.response_headers
# }

# output "body" {
#   value = data.http.openshift_auth.response_body
# }

# output "status_code" {
#   value = data.http.openshift_auth.status_code
  
# }