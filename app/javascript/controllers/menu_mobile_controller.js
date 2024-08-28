import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu-mobile"
export default class extends Controller {
  static targets = ["menu"]

  toggle() {
    console.log('toggle');

    // Remover event listener anterior para evitar múltiplos anexos
    this.menuTarget.removeEventListener('animationend', this._handleAnimationEnd);

    if (this.menuTarget.classList.contains('hidden')) {
      // Exibir o menu com a animação de entrada
      this.menuTarget.classList.remove('hidden', 'animate__fadeOutUp');
      this.menuTarget.classList.add('animate__animated', 'animate__fadeInDown');
      console.log('fadeInDown');
    } else {
      // Esconder o menu com a animação de saída
      this.menuTarget.classList.remove('animate__fadeInDown');
      this.menuTarget.classList.add('animate__fadeOutUp');
      console.log('fadeOutUp');

      // Anexar o evento de animação para adicionar `hidden` após a animação
      this.menuTarget.addEventListener('animationend', this._handleAnimationEnd.bind(this), { once: true });
    }
  }

  _handleAnimationEnd() {
    console.log('animationend');
    if (this.menuTarget.classList.contains('animate__fadeOutUp')) {
      this.menuTarget.classList.add('hidden');
      console.log('hidden');
    }
  }
}
