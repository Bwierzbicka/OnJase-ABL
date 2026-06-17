import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card", "counter"]

  connect() {
    this.currentIndex = 0
    this.showCard(0)
  }

  flip(event) {
    event.currentTarget.classList.toggle("flipped")
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

  showCard(index) {
    this.cardTargets.forEach((card, i) => {
      card.classList.toggle("d-none", i !== index)
      card.classList.remove("flipped")
    })
    this.counterTarget.textContent = `Card ${index + 1} of ${this.cardTargets.length}`
  }
}
