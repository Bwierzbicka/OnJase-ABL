import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="partial-user-search"
export default class extends Controller {
  static targets = ["input"]
  static values = { url: String }

  connect() {
    console.log(this.urlValue)
  }
  //
  searchUsername() {
    const csrfToken = document.querySelector("meta[name='csrf-token']").content
    console.log(this.urlValue)
    fetch(this.urlValue, {
      method: "POST",
      headers: {
        "X-CSRF-Token": csrfToken,
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: new URLSearchParams({ query: this.inputTarget.value })
    })
  }
}
