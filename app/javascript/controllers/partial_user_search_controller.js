import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="partial-user-search"
export default class extends Controller {
  static targets = ["input"]

  connect() {
    console.log('all quiet on the western front')
  }

  searchUsername() {
    console.log(this.inputTarget.value)
  }
  // add event listener for key up and then when you type the username it updates with the suggestions
}
