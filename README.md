# JubiOrder

- docs/aws.md -> how I set up multiple accounts for this project

# To Do's
- [ ] learn about terragrunt units and see if can be applied here
- [ ] create cicd pipeline for deploying infra
- [ ] modify terragrunt setup to support multiple dev,prod envs (diff with account id?)

# Usage
- install [mise](https://mise.jdx.dev/getting-started.html#installing-mise-cli)
- run `mise install` from repo root dir
- `aws configure sso`
- `aws sso login --profile dev` if you have already set up sso before
- plan dev: `export AWS_PROFILE=dev && cd infra/live/eu-central-1/dev01 && terragrunt run --all plan && cd -`
