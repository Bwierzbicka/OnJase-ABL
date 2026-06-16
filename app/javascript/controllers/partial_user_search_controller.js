import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="partial-user-search"
export default class extends Controller {
  static targets = ["input"]
  static values = { url: String }

  connect() {
    console.log(this.urlValue)
  }

  searchUsername() {
    const csrfToken = document.querySelector("meta[name='csrf-token']").content
    console.log(this.inputTarget.value)
    console.log(this.urlValue)
    fetch(this.urlValue, {
      method: "POST",
      headers: {
        "X-CSRF-Token": csrfToken,
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: { query: this.inputTarget.value }
    })
  }
  // add event listener for key up and then when you type the username it updates with the suggestions
}
