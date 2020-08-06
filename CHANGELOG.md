## v0.6.3 (Aug 06, 2020)

NOTES:
* Add .pre-commit-config.yaml to include terraform_fmt and terraform_docs
* Update README.md to be informative

## v0.6.2 (Jan 30, 2020)

ENHANCEMENTS:

* Added a variable to control deletion protection for the rds instance. The default value is `false`.

NOTES:
* The default value of `deletion_protection` argument is false. The `deletion_protection` variable default value also set to `false`. Updating to this version without setting `deletion_protetion` argument to true should not trigger changes.

## v0.6.1 (Jan 21, 2020)

ENHANCEMENTS:

* Add support for rds ca_cert_identifier attribute

WARNING:
Please verify the value of apply_immediately variable, before update the version of terraform module in existed infrastructure.
* With apply_immediately set to true, the instance **will restart immediately** and the new certificate will be used by the instance.
* With apply_immediately parameter set to false. The instance **will restart on the next maintenance window**. Terraform will still show changes needed for this parameter between ca_cert_identifier changed to rds-ca-2019 until the instance restart on the maintenance window.

## v0.6.0 (Jan 25, 2020)

FEATURES:

* Performance insights are now available to configure
* The default value for performance insights is false

## v0.5.0 (Feb 4, 2019)

FEATURES:

* Add new variable bastion security group

## v0.4.0 (Oct 23, 2018)

FEATURES:

* multi az support for read replica

## v0.3.0 (Sep 5, 2018)

FEATURES:

* Add capability to create RDS postgres master from RDS postgres snapshot
