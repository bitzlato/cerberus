
# KYC-Service

API for kyc. Works with https://sumsub.com/

# Development

Installation:
```bash
bundle install
rails db:setup
```

## Env

- DATABASE_NAME - url of postgres 


## Credentials 

We are using credentials for all env 


```yaml
sumsub:
  token: #Token from sumsub
  secret: #Secret from sumsub
  webhook_secret_key: #Secret from Webhook. Verifies webhook request
  production: #boolean. Sandbox or Production env. Default false. 
```


