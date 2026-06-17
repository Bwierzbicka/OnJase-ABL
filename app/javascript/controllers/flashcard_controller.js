import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card", "counter", "scoreButtons", "nav", "results", "scoreDisplay"]
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
    const isLast = this.currentIndex === this.cardTargets.length - 1

    fetch(this.recordScoreUrlValue, {
      method: "POST",
      headers: { "Content-Type": "application/json", "X-CSRF-Token": csrfToken },
      body: JSON.stringify({ flashcard_id: flashcardId, correct })
    }).then(res => res.json()).then(data => {
      if (isLast) this.showResults(data.score)
    })

    if (!isLast) this.next()
  }

  showResults(score) {
    this.cardTargets.forEach(card => card.classList.add("d-none"))
    this.scoreButtonsTarget.classList.add("d-none")
    this.navTarget.classList.add("d-none")
    this.counterTarget.textContent = ""
    this.scoreDisplayTarget.textContent = score !== null ? `${Math.round(score * 100)}%` : "N/A"
    this.resultsTarget.classList.remove("d-none")
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
