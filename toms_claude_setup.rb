require 'fileutils'

target = ARGV[0] || Dir.pwd

files = {
  "CLAUDE.md" => <<~MARKDOWN,
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
  MARKDOWN

  "app/javascript/CLAUDE.md" => <<~MARKDOWN,
    # JavaScript — Stimulus conventions

    All JS in this project is written as Stimulus controllers. No inline scripts, no bare `addEventListener` calls outside a controller.

    ## Creating a controller

    1. Add `app/javascript/controllers/<name>_controller.js` — auto-loaded by `controllers/index.js`.
    2. Wire it up in HTML with `data-controller="<name>"`.

    ```js
    import { Controller } from "@hotwired/stimulus"

    export default class extends Controller {
      static targets = ["input"]   // → this.inputTarget / this.inputTargets
      static values  = { url: String }  // → this.urlValue

      connect() { /* called when element enters the DOM */ }
      disconnect() { /* cleanup */ }
    }
    ```

    ## HTML attributes

    | Purpose | Attribute |
    |---|---|
    | Mount controller | `data-controller="name"` |
    | Declare a target | `data-name-target="targetName"` |
    | Bind an action | `data-action="click->name#method"` |
    | Pass a value | `data-name-url-value="<%= some_path %>"` |

    Default event per element (`input`→`input`, `form`→`submit`, `a/button`→`click`) can be omitted: `data-action="name#method"`.

    ## Adding an external library

    1. Pin it in `config/importmap.rb`:
       ```ruby
       pin "library-name", to: "https://cdn.example.com/library.esm.js"
       ```
    2. Import it inside the controller that needs it — not globally:
       ```js
       import LibraryName from "library-name"
       ```
  MARKDOWN

  "app/views/CLAUDE.md" => <<~MARKDOWN,
    # Views — styling conventions

    Use BootStrap utility classes first. Only write custom CSS when the utility classes genuinely can't achieve the result.

    When working on views, suggest extracting repeated or self-contained chunks into partials if it would genuinely improve clarity. Only flag it when the view would be meaningfully easier to read or reuse as a result.
  MARKDOWN
}

files.each do |relative_path, content|
  full_path = File.join(target, relative_path)
  FileUtils.mkdir_p(File.dirname(full_path))
  File.write(full_path, content)
  puts "Created #{full_path}"
end
