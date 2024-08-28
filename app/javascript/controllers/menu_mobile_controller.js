import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu-mobile"
export default class extends Controller {
  static targets = ["menu"]

  toggle() {

    this.menuTarget.removeEventListener('animationend', this._handleAnimationEnd);

    if (this.menuTarget.classList.contains('hidden')) {
      this.menuTarget.classList.remove('hidden', 'animate__fadeOutUp');
      this.menuTarget.classList.add('animate__animated', 'animate__fadeInDown');
    } else {
      this.menuTarget.classList.remove('animate__fadeInDown');
      this.menuTarget.classList.add('animate__fadeOutUp');

      this.menuTarget.addEventListener('animationend', this._handleAnimationEnd.bind(this), { once: true });
    }
  }

  _handleAnimationEnd() {
    if (this.menuTarget.classList.contains('animate__fadeOutUp')) {
      this.menuTarget.classList.add('hidden');
    }
  }
}
