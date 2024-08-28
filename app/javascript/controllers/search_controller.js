import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = [ "search" ]
  connect() {
  }

  openSearch() {
    this.searchTarget.removeEventListener('animationend', this._handleAnimationEnd)

    if (this.searchTarget.classList.contains('hidden')) {
      this.searchTarget.classList.remove('hidden');
      this.searchTarget.classList.add('animate__animated', 'animate__fadeInDown');
    } else {
      this.searchTarget.classList.remove('animate__fadeInDown');
      this.searchTarget.classList.add('animate__fadeOutUp');
      
      this.searchTarget.addEventListener('animationend', this.__handleAnimationEnd.bind(this), { once: true });

    }
  }

  __handleAnimationEnd() {
    if (this.searchTarget.classList.contains('animate__fadeOutUp')) {
      this.searchTarget.classList.add('hidden');
    }
  }
}
