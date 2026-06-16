import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "trigger", "panel"]
  static values  = { url: String }

  connect() {
    this._timer = null
  }

  disconnect() {
    clearTimeout(this._timer)
  }

  inputChanged() {
    clearTimeout(this._timer)
    if (!this.inputTarget.value.trim()) {
      // apply new fade out css class
      // make sure on animation end is used before the class with d-none is added
      this.triggerTarget.classList.add("d-none")
      return
    }
    this._timer = setTimeout(() => this.triggerTarget.classList.remove("d-none"), 800)
  }

  close() {
    this.panelTarget.classList.add("d-none")
  }

  open() {
    this.panelTarget.classList.remove("d-none")
    this._resetToSpinner()

    const url = `${this.urlValue}?message_text=${encodeURIComponent(this.inputTarget.value)}`
    fetch(url, { headers: { "X-Requested-With": "XMLHttpRequest" } })
  }

  _resetToSpinner() {
    const typingDiv = document.getElementById("conversation-typing-assistant")
    if (typingDiv) {
      typingDiv.innerHTML = `
        <div class="d-flex align-items-center gap-2 text-muted">
          <div class="spinner-border spinner-border-sm" role="status"></div>
          <small>Analyse en cours…</small>
        </div>`
    }
  }
}
