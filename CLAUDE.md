# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Stack: Ruby 3.3.5, Rails 8.1.1, PostgreSQL, BootStrap, Sprockets(not Propshaft), simple_form, Devise
<!-- This needs to be changed to reflect project setups -->

### Rails conventions and "magic"

If using any "rails magic": shortcuts, type inferrence, build_association. Explain what is happening and offer the "long way" to show the purpose.

### Branch context

At the start of any work on a branch, check the branch name for an issue number. If one is present (e.g. `feature/42-add-reviews`), run `gh issue view <number>` and use the title, description, and comments as context before starting.

### Commits

While working on a branch, suggest good moments to commit and briefly explain why it is a natural checkpoint (e.g. a feature is working, a refactor is complete, tests pass, a logical unit of work is done).

### Refactoring

When making a refactor, always explain what is changing and why it is beneficial before making the change.

## JavaScript

All JavaScript must be written as Stimulus controllers. No inline scripts or bare `addEventListener` calls.
