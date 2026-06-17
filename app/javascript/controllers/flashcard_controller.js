import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card", "counter", "scoreButtons"]
  static values  = { recordScoreUrl: String }

  connect() {
    this.currentIndex = 0
    this.showCard(0)
  }

  flip(event) {
    const card = event.currentTarget
    card.classList.toggle("flipped")
    const isFlipped = card.classList.contains("flipped")
    this.scoreButtonsTarget.classList.toggle("d-none", !isFlipped)
  }

  next() {
    if (this.currentIndex < this.cardTargets.length - 1) {
      this.currentIndex++
      this.showCard(this.currentIndex)
    }
  }

  prev() {
    if (this.currentIndex > 0) {
      this.currentIndex--
      this.showCard(this.currentIndex)
    }
  }

  score(event) {
    const correct = event.currentTarget.dataset.correct
    const flashcardId = this.cardTargets[this.currentIndex].dataset.flashcardId
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content

    fetch(this.recordScoreUrlValue, {
      method: "POST",
      headers: { "Content-Type": "application/json", "X-CSRF-Token": csrfToken },
      body: JSON.stringify({ flashcard_id: flashcardId, correct })
    })

    this.next()
  }

  showCard(index) {
    this.cardTargets.forEach((card, i) => {
      card.classList.toggle("d-none", i !== index)
      card.classList.remove("flipped")
    })
    this.scoreButtonsTarget.classList.add("d-none")
    this.counterTarget.textContent = `Card ${index + 1} of ${this.cardTargets.length}`
  }
}
