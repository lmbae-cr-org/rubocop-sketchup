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

### Baseline

To focus the report on new offenses, record the current offenses in a baseline file:

```bash
RUBOCOP_SKETCHUP_WRITE_BASELINE=1 rubocop -f extension_review -o report.html
```

This writes `.rubocop-sketchup-baseline.yml` to the working directory. Commit it to your project. Later runs leave out the offenses listed in the baseline and show how many were hidden. Set `RUBOCOP_SKETCHUP_BASELINE` to use a different path.

See [RuboCop's documentation](https://rubocop.readthedocs.io/en/latest/formatters/) for more examples.
