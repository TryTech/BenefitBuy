import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cart"
export default class extends Controller {
  static targets = [ "cart" ]
  connect() {
  }

  handleCart() {
    this.cartTarget.removeEventListener('animationend', this._handleAnimationEnd)

    if (this.cartTarget.classList.contains('hidden')) {
      this.cartTarget.classList.remove('hidden');
      this.cartTarget.classList.add('animate__animated', 'animate__fadeIn');
    } else {
      this.cartTarget.classList.remove('animate__fadeIn');
      this.cartTarget.classList.add('animate__fadeOut');
      
      this.cartTarget.addEventListener('animationend', this._handleAnimationEnd.bind(this), { once: true });
    }
  }

  _handleAnimationEnd() {
    if (this.cartTarget.classList.contains('animate__fadeOut')) {
      this.cartTarget.classList.add('hidden');
    }
  }
}
