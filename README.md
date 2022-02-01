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
- SUMSUB_TOKEN - Token from sumsub
- SUMSUB_SECRET - Secret from sumsub
- SUMSUB_WEBHOOK_SECRET_KEY - Secret from Webhook. Verifies webhook request
- SUMSUB_PRODUCTION - boolean. Sandbox or Production env. Default false. 


