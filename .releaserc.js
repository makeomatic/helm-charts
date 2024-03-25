exports.branches = [
  { "name": "master" },
  { "name": "staging", "prerelease": "rc" }
]

exports.plugins = [
  ["@semantic-release/commit-analyzer", {
    "preset": "angular",
    "releaseRules": [
      { "type": "docs", "release": "patch" },
      { "type": "refactor", "release": "patch" },
      { "type": "style", "release": "patch" },
      { "type": "minor", "release": "minor" },
      { "type": "patch", "release": "patch" },
      { "type": "major", "release": "major" },
      { "type": "breaking", "release": "major" }
    ]
  }],
  "@semantic-release/changelog",
  ["@semantic-release/npm", { "npmPublish": false }],
  ["@semantic-release/exec", { "prepareCmd": "HELM_VERSION=3.14.3 ./scripts/sync-charts.sh" }],
  "@semantic-release/git",
  "@semantic-release/github"
]
