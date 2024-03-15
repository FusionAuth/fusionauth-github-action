# FusionAuth GitHub Marketplace Action

This Action allows you to run FusionAuth in your GitHub workflows.

For instance, you could start FusionAuth in one step, then run login tests using Playwright in the next step, ensuring that any changes committed to your repository don't break a user's ability to log in.

This Action uses PostgreSQL database search for user search functionality, not Elasticsearch. The Elasticsearch Docker image is too resource intensive for GitHub workflows. If you need to support tests that use Elasticsearch, rather write a custom step in your GitHub workflow that references your own Docker compose file that includes Elasticsearch.

## Inputs

You can optionally supply the FusionAuth version number (defaults to `1.48.3`) you want to use otherwise you shouldn't need to change any of the values below.

```yaml
  FUSIONAUTH_VERSION:
    default: "1.48.3"
  DATABASE_USERNAME:
    default: fusionauth
  DATABASE_PASSWORD:
    default: hkaLBM3RVnyYeYeqE3WI1w2e4Avpy0Wd5O3s3
  FUSIONAUTH_APP_KICKSTART_FILE:
    default: /usr/local/fusionauth/kickstart/kickstart.json
  FUSIONAUTH_APP_MEMORY:
    default: 512M
  FUSIONAUTH_APP_RUNTIME_MODE:
    default: development
  OPENSEARCH_JAVA_OPTS:
    default: '"-Xms512m -Xmx512m"'
  POSTGRES_USER:
    default: postgres
  POSTGRES_PASSWORD:
    default: postgres
```

## Outputs

None

## Secrets

This Action uses no secrets. The FusionAuth instance is temporary and uses the standard example usernames and passwords.

For your tests, you can use users `admin@example.com` and `richard@example.com`, with password `password`.

## Example of use

Make a `.github/workflows/test.yaml` file in your repository and add steps similar to the code below. FusionAuth has an article about testing in GitHub workflows in their documentation.

```yaml
name: Test FusionAuth login
on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  run-tests:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Start FusionAuth
        uses: fusionauth/fusionauth-github-action@main
        #uses: fusionauth/fusionauth-github-action@v1
        with:
          FUSIONAUTH_VERSION: "1.48.3" # Optional: provide FusionAuth version number otherwise it defaults to 1.48.3

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'

      - name: Install npm dependencies
        run: |
          npm install
          npx playwright install-deps
          npx playwright install
        working-directory: ./app

      - name: Start app
        run: npm run start & # & in background
        working-directory: ./app

      - name: Run Playwright tests
        run: npx playwright test --project=chromium
        working-directory: ./app
```
