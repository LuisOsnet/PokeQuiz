import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if (!this.element.classList.contains("hidden")) {
      this.open()
    }
  }

  open() {
    this.element.classList.remove("hidden")
  }

  close() {
    this.element.classList.add("hidden")
  }
}
