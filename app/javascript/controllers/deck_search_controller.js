import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "status", "submit"]

  connect() {
    const list = document.getElementById("decks-list")
    if (!list) return
    this.observer = new MutationObserver(() => this.restore())
    this.observer.observe(list, { childList: true })
  }

  disconnect() {
    this.observer?.disconnect()
  }

  submit() {
    this.inputTarget.setAttribute("readonly", true)
    this.inputTarget.classList.add("d-none")
    this.submitTarget.classList.add("d-none")
    this.statusTarget.classList.remove("d-none")
  }

  restore() {
    this.inputTarget.removeAttribute("readonly")
    this.inputTarget.value = ""
    this.inputTarget.classList.remove("d-none")
    this.submitTarget.classList.remove("d-none")
    this.statusTarget.classList.add("d-none")
  }
}
