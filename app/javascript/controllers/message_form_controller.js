import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.autoGrow()
  }

  autoGrow() {
    const el = this.inputTarget
    el.style.height = "auto"
    el.style.height = el.scrollHeight + "px"
  }

  clear() {
    this.inputTarget.value = ""
    this.inputTarget.style.height = "40px"
  }
}
