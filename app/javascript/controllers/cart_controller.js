import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cart"
export default class extends Controller {
  static targets = ["cart"]

  connect() {
    this.handleClickOutside = this.handleClickOutside.bind(this)
  }

  handleCart() {
    this.cartTarget.classList.toggle('hidden')

    if (!this.cartTarget.classList.contains('hidden')) {
      document.addEventListener('click', this.handleClickOutside)
    } else {
      document.removeEventListener('click', this.handleClickOutside)
    }
  }

  handleClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.cartTarget.classList.add('hidden')
      document.removeEventListener('click', this.handleClickOutside)
    }
  }
}
