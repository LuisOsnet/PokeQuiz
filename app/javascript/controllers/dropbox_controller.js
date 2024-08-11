import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content"];

  initialize() {
    document.addEventListener("click", this.handleDocumentClick.bind(this));
  }

  handleDocumentClick(event) {
    if (!this.element.contains(event.target)) {
      this.hideContent();
    }
  }

  toggle() {
    this.contentTarget.classList.toggle("hidden");
  }

  hideContent() {
    this.contentTarget.classList.add("hidden");
  }
}