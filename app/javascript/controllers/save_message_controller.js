import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]
  static values = { url: String, item: String }

  toggle() {
    this.buttonTarget.classList.toggle("save-message-btn--visible")
  }

  save(event) {
    event.stopPropagation()
    const csrfToken = document.querySelector("meta[name='csrf-token']").content
    fetch(this.urlValue, {
      method: "POST",
      headers: {
        "X-CSRF-Token": csrfToken,
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: new URLSearchParams({ item: this.itemValue })
    }).then(() => {
      const btn = this.buttonTarget
      btn.classList.add("save-message-btn--saved")
      btn.textContent = "TIGIDOU"
    })
  }
}
