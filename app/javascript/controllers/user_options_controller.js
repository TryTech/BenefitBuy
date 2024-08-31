import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-options"
export default class extends Controller {
  static targets = ["options"]

  connect() {
    this.handleClickOutside = this.handleClickOutside.bind(this)
  }

  openOptions() {
    this.optionsTarget.classList.toggle('hidden')

    if (!this.optionsTarget.classList.contains('hidden')) {
      document.addEventListener('click', this.handleClickOutside)
    } else {
      document.removeEventListener('click', this.handleClickOutside)
    }
  }

  handleClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.optionsTarget.classList.add('hidden')
      document.removeEventListener('click', this.handleClickOutside)
    }
  }
}
