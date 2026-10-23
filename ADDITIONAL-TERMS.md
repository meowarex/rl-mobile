# Additional Terms

These terms supplement the GNU General Public License v3.0 (`LICENSE`) under **Section 7** of
that licence. They apply to all code in this repository. The GPL-3.0 text itself is unchanged.

---

## 1. Attribution Requirement

Per GPL-3.0 §7(b), if you publish **any public project** that uses, includes, forks, modifies,
ports, or is otherwise derived from this code (in whole or in part), you **must** credit the
original work in both of the following places.

### 1.1 Project README

The credit must appear in that project's **README** (or, if it has no README, its main page or
primary documentation).

### 1.2 Within the application

If the work has a user interface, the credit must also be displayed **prominently within the
application itself** and form part of its Appropriate Legal Notices (GPL-3.0 §5(d)), for
example on an About, Credits, or Settings screen that users can readily find.

### 1.3 Form of credit

In both places, the credit must:

- be clearly visible, not hidden in a footnote, a collapsed section, a tooltip, or a commit
  message, and
- link to **one** of the following:
  - <https://radiant-lyrics.org>
  - <https://github.com/meowarex/rl-mobile>

Example wording:

```md
Based on [Radiant Lyrics](https://radiant-lyrics.org) by meowarex.
```

You may not remove or obscure this credit, or any existing author attributions, from copies or
derivative works you distribute.

---

## 2. Exclusion of Hosted Services

> **The GPL-3.0 licence applies only to the source code in this repository. It does not extend
> to, and grants no rights of access to or use of, any server, service, or infrastructure
> operated by the author (atomix / meowarex).**

The following are expressly excluded from this licence (the "Services"):

- **All endpoints served from `api.radiant-lyrics.org` and `api.atomix.one`**, including but not
  limited to `/rl-api`, romanization, and Sylla, together with any current or future routes
- **All credentials, API keys, access tokens, and other secrets** contained in, or obtainable
  from, this repository, its compiled builds, or its network traffic
- **Any other server, domain, database, or backend system** operated by the author

The Services are provided solely for use by the official builds published from this
repository. Unless you have prior written permission from the author, you may not:

- access, call, proxy, or scrape the Services from any other application, fork, plugin, script,
  bot, or service
- use, copy, disclose, or redistribute any credentials associated with the Services
- distribute a fork or derivative work that is configured to connect to the Services
- load-test the Services, or attempt to circumvent any rate limit, authentication, or other
  access control

The availability of source code or observable network requests does not constitute
authorization to use the Services. Any fork or derivative work must remove or replace all
references to the Services with infrastructure under its own control.

**These restrictions are actively enforced.** Usage is monitored, unauthorized clients are
blocked, and credentials are rotated without notice. Violations may be reported to the relevant
service providers and may result in further action where appropriate.

Requests for authorized API access may be directed to <enquire@radiant-lyrics.org>.
