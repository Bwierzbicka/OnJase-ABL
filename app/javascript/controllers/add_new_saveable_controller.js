import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "status", "submit", "overlay", "wordsEmpty", "phrasesEmpty"]

  connect() {
    this.observers = [
      this.observeList("words-list", this.hasWordsEmptyTarget ? this.wordsEmptyTarget : null),
      this.observeList("phrases-list", this.hasPhrasesEmptyTarget ? this.phrasesEmptyTarget : null)
    ].filter(Boolean)
  }

  disconnect() {
    this.observers.forEach((observer) => observer.disconnect())
  }

  observeList(listId, emptyTarget) {
    const list = document.getElementById(listId)
    if (!list) return null

    const observer = new MutationObserver(() => {
      emptyTarget?.classList.add("d-none")
      this.restore()
    })
    observer.observe(list, { childList: true })
    return observer
  }

  open() {
    this.overlayTarget.classList.remove("deck-overlay--hidden")
    this.inputTarget.focus()
  }

  close() {
    this.overlayTarget.classList.add("deck-overlay--hidden")
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
    this.close()
  }
}
