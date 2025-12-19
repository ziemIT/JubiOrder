# JubiOrder

- docs/aws.md -> how I set up multiple accounts for this project

# To Do's
- learn about terragrunt units and see if can be applied here
- create cicd pipeline for deploying infra

# Usage
- install mise
- run `mise install` from repo root dir
- `aws configure sso`
- plan dev: `export AWS_PROFILE=dev; cd infra/live/dev; terragrunt run --all plan; cd -`
