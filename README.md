# JubiOrder

- docs/aws.md -> how I set up multiple accounts for this project

# Usage
- install [mise](https://mise.jdx.dev/getting-started.html#installing-mise-cli)
- run `mise install` from repo root dir
- `aws configure sso`
- `aws sso login --profile dev` if you have already set up sso before
- plan dev: `export AWS_PROFILE=dev && cd infra/live/eu-central-1/dev/dev01 && terragrunt run --all plan && cd -`

# To Do's
- [ ] learn about terragrunt units and see if can be applied here
- [ ] create cicd pipeline for deploying infra
- [ ] add boto3 type hints in source code
- [ ] in routes/products/ change code to use src.helpers, make it work and remove file from route path 
- [ ] checkout sam local invoke https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/using-sam-cli-local-invoke.html
- [ ] disable auto log out after 1 h while using aws console

# Done so far
- [x] modify terragrunt setup to support multiple dev,prod envs (diff with account id?)
- [x] deploy 1 apigw for all dev envs