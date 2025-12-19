this is how I set up accounts and users for this project using cloudflare email routing feature.

NOTE: I used cloudflare because I have my domain there.

in cloudflare dashboard, using email routing I created 2 routing rules
which forward emails to my personal email account.

aws-dev@domain.com
aws-prd@domain.com

this step was required to allow me to set up aws organizations.

so then i enabled aws organizations (free service) and created new organization.
inside i created org unit for my project and 2 child OUs:
```
root
    -> JubiOrder
        -> dev
            -> dev account
        -> prod
            -> prod account
    -> my management account
```

next, on my management account i enabled IAM Identity Center (free service) and sso.
then i created Permission Sets with proper policies assigned (TODO: provide more details).

Then i created new user called tofu-admin and assigned him to 2 user groups:
    -> DevDeployers
    -> ProdDeployers

so the same user has access to different account with proper permissions

Then i assigned permission sets to my aws accounts so that:
 - dev account has DevAccountAccess permission set assigned
 - prod account has ProdAccountAccess permission set assigned

then from setting i've copied access portal URL
and configured sso on my local machine using `aws configure sso` command

this allows me to deploy application from my PC to different aws account by
using different AWS_PROFILEs.
to deploy to dev account I would run:
1. `export AWS_PROFILE=dev`
2. `cd dev; terragrunt run --all plan; cd -`

`~/.aws/config` file looks like this:

```toml
[profile dev]
region = eu-central-1
output = json
sso_session = dev
sso_account_id = 1234567890
sso_role_name = DevAccountAccess

[sso-session dev]
sso_start_url = https://d-xxxxxxxx.awsapps.com/start
sso_region = eu-central-1
sso_registration_scopes = sso:account:access
```
