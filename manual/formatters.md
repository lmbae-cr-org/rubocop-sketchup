# Formatters

RuboCop comes with a set of different formatters that let you control how the results are presented.

If you want to output the result in machine readable JSON;

```bash
rubocop --format json --out results.json
```

The `rubocop-sketchup` gem provides a custom formatter designed for SketchUp related cops. It explains which cops to focus your attention on.

```bash
rubocop -f extension_review -o report.html
```

When the inspected project is a Git repository the report header shows the current branch and commit, so a report can be traced back to the source it was generated from.

By default the report shows only the line of each offense. Set `RUBOCOP_SKETCHUP_CONTEXT_LINES` to include surrounding lines:

```bash
RUBOCOP_SKETCHUP_CONTEXT_LINES=3 rubocop -f extension_review -o report.html
```

See [RuboCop's documentation](https://rubocop.readthedocs.io/en/latest/formatters/) for more examples.
