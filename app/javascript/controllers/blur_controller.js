import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "image"]

  connect() {
    this.formTarget.addEventListener("submit", this.handleSubmit.bind(this))
  }

  handleSubmit(event) {
    event.preventDefault()
    this.removeBlur()
    this.formTarget.submit()
  }

  removeBlur() {
    this.imageTarget.style.filter = "none"
  }
}
