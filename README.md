# Github-Release-Action

[![Actions Status](https://github.com/kuloud/Github-Release-Action/workflows/Release/badge.svg)](https://github.com/kuloud/Github-Release-Action/actions)

Creates a plain Github release, without attaching assets or source code.

## Usage

```yaml
name: Publish Release
on:
  push:
    tags:
      - "v*"
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Create a Release
        uses: kuloud/Github-Release-Action@v1
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          title: MyReleaseMessage
          draft: false
          prerelease: false
```

## Mandatory Arguments

### title

`title` is a message which should appear in the release. May contain spaces.

## Optional Arguments

### tag_name

`tag_name` is the name of the tag for the release. If not provided, it will use the current git tag.

### body

`body` is the text content of the release. Can be used to provide detailed release notes.

### draft

`draft` determines whether the release should be created as a draft. Default is false.

### prerelease

`prerelease` specifies if this is a prerelease. Default is false.

### workdir

`workdir` can be used to specify a directory that contains the repository to be published.

### generate_notes

`generate_notes` automatically generates release notes if set to true. Default is false.

### notes

`notes` allows you to specify release notes directly.

### notes_file

`notes_file` is the path to a file containing release notes.

### discussion_category

`discussion_category` specifies the GitHub Discussions category to create for this release.

### target

`target` allows you to specify the target branch or commit for the release.

### verify_tag

`verify_tag` verifies if the tag exists before creating the release. Default is false.

## Notes

`${{ secrets.GITHUB_TOKEN }}` can be used for publishing, if you configure the correct permissions.

This can be done by giving the Github token _all_ permissions (referred to as "Read and write permission") with the setting below available in Settings > Actions > General  
![Screenshot of permission setting](permissions.png)
OR alternatively it can be achieved via adding

```yaml
permissions:
  packages: write
  contents: write
```

to the concrete job creating the release. For more details see the [documentation on token permissions.](https://docs.github.com/en/actions/security-guides/automatic-token-authentication#modifying-the-permissions-for-the-github_token)
