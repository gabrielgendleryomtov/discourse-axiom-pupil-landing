# axiom-landing

Discourse plugin for Axiom Maths providing a pupil-focused landing page.

## Features
- Redirect configured pupils from homepage routes to `/landing`.
- Redirect staff from homepage routes to the chat channel linked to the configured staff category.
- Show two prominent actions on the landing page:
  - Team chat channel
  - Forum category
- Keep standard Discourse navigation (header/sidebar) while replacing only main content.

## Settings
- `axiom_landing_enabled` (default: true)
- `axiom_landing_pupil_groups` (default: "", accepts multiple groups)

## Notes
- Team and forum links are resolved server-side using each pupil's current permissions.
- If a link cannot be resolved (e.g. chat disabled), the landing page shows a clear unavailable message.
