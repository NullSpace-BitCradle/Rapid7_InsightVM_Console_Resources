# Notice and attribution

This repository is a documentation set about the InsightVM reporting data model plus a folder of example SQL queries. Not all of it is original work. This file says what came from Rapid7 and under what terms, as far as I could confirm.

## Rapid7 example queries (QUERIES/)

Most of the 149 files in `QUERIES/` are copies of queries published in the public Rapid7 repository:

- https://github.com/rapid7/insightvm-sql-queries

I compared every file in `QUERIES/` against that repository (checked 2026-11-18, upstream commit `ef4e939`), ignoring comments, whitespace and letter case:

| Result | Files |
|--------|-------|
| Same SQL as a file in the Rapid7 repository | 131 |
| Close variant of a file in the Rapid7 repository (small edits or fixes) | 9 |
| No match in the Rapid7 repository | 9 |

The 9 with no match are `ASSET_SERVICES_DETAIL`, `ASSET_SOFTWARE_DETAIL`, `COMPREHENSIVE_ASSET_INVENTORY`, `CURRENT_VULNERABILITY_SNAPSHOT`, `EXECUTIVE_SUMMARY_QUERY`, `HISTORICAL_VULNERABILITY_FINDINGS`, `POLICY_COMPLIANCE_STATUS`, `REMEDIATION_EXCEPTION_TRACKING` and `WEEKLY_INCREMENTAL_VULNERABILITIES`. "No match" means only that I found no copy in that one repository. This repo does not record where those 9 came from.

`FOUND_NETWORKS.sql` also cites a Rapid7 blog post as its source.

### License of the Rapid7 repository

The Rapid7 repository has a `LICENSE` file with the MIT license, "Copyright (c) 2022 Rapid7." Its text is reproduced below, as that license requires for copies and substantial portions.

```
Copyright (c) 2022 Rapid7.
MIT License
===========
Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:
The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```

The MIT license in this repository's `LICENSE` file covers only what this repository's owner wrote. It does not replace Rapid7's copyright on the queries above.

### A file that was removed

`BEST_SOLUTION_PER_VULNERABILITY_ON_EACH_ASSET.sql` was removed from the current tree. It carried a per-file header that claimed it was unpublished, confidential Rapid7 material (copyright 2016) and named a Rapid7 employee with a work email address. That header does not match the MIT license of the repository the file came from, so I could not confirm what terms applied to the file and did not keep it. The same header appears in the upstream copy. The file is still in this repository's git history.

## Table reference text (COMPLETE_TABLE_REFERENCE.md and the JSON schema files)

`COMPLETE_TABLE_REFERENCE.md` names "Official Rapid7 Documentation + Manual Field Enumeration" as its source. Many table and column descriptions use Rapid7's wording from the public reporting data model pages:

- https://docs.rapid7.com/insightvm/understanding-the-reporting-data-model-facts/
- https://docs.rapid7.com/insightvm/understanding-the-reporting-data-model-dimensions/

The JSON schema files and the ERD were generated from that reference. I could not confirm the license or reuse terms for the text on docs.rapid7.com, so this repository makes no claim of a license for that wording. Rapid7 keeps whatever rights it has in it. If you need to reuse it, check Rapid7's terms.

## Not affiliated

This is an independent project. It is not made, endorsed or verified by Rapid7. "Rapid7" and "InsightVM" are Rapid7's names.
