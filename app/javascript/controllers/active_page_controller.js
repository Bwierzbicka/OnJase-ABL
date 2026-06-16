import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["link"]

  connect() {
    console.log("connected")
  }

  select(event) {
    this.linkTargets.forEach(link => link.classList.remove("active"))
    event.currentTarget.classList.add("active")
  }
}
