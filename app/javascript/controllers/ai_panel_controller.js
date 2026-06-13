import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel"]
  static values = { url: String }

  toggle() {
    const opening = this.panelTarget.classList.contains("d-none")
    this.panelTarget.classList.toggle("d-none")
    if (opening) fetch(this.urlValue)
  }
}
