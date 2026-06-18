import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "status"]

  connect() {
    const list = document.getElementById("decks-list")
    if (!list) return
    this.observer = new MutationObserver(() => this.statusTarget.classList.add("d-none"))
    this.observer.observe(list, { childList: true })
  }

  disconnect() {
    this.observer?.disconnect()
  }

  submit() {
    this.inputTarget.value = ""
    this.statusTarget.classList.remove("d-none")
  }
}
