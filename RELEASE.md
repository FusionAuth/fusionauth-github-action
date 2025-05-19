## Release process

This is the release process. It is in a separate doc because the README gets published to the marketplace: https://github.com/marketplace/actions/fusionauth-action

To release after you've tested the new functionality works, push up the `main` branch:

```
git push origin main
```

Then create a new tag:

```
git tag 1.0.5
```

Then, move the `v1` tag to the latest:

```
git tag --force v1
```

Then push up the tags (using -f because of the v1 tag already existing):

```
git push origin main --tags -f
```

Then go to https://github.com/FusionAuth/fusionauth-github-action/releases and draft a new release. Make sure you publish tto the marketplace and pick the specific tag (`1.0.5`, *not* `v1`) to release.

Release it.

https://github.com/marketplace/actions/fusionauth-action should be updated very quickly.

More details: https://docs.github.com/en/actions/creating-actions/releasing-and-maintaining-actions
