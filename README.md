
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
- SUMSUB_TOKEN 
- SUMSUB_SECRET 
- SUMSUB_WEBHOOK_SECRET_KEY 
- SUMSUB_PRODUCTION=false
- DATABASE_URL=postgres://postgres:{{ postgres.password }}@{{ postgres.host }}:{{ item.0.ports.db }}/kyc_staging
