import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="partial-user-search"
export default class extends Controller {
  static targets = ["input", "form", "query"]

  searchUsername() {
    this.queryTarget.value = this.inputTarget.value
    this.formTarget.requestSubmit()
  }
}
