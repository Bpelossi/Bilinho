import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]

  connect() {
    this.handleClickOutside = this.handleClickOutside.bind(this)
    document.addEventListener("click", this.handleClickOutside)
  }

  disconnect() {
    document.removeEventListener("click", this.handleClickOutside)
  }

  search() {
    const query = this.inputTarget.value.trim()
    if (query.length < 2) {
      this.resultsTarget.innerHTML = ""
      return
    }

    const type = this.inputTarget.dataset.autocompleteType || "students"

    fetch(`/${type}/search?q=${encodeURIComponent(query)}`)
      .then(response => response.json())
      .then(data => {
        this.resultsTarget.innerHTML = data.map(item => `
          <div data-action="click->autocomplete#select" data-id="${item.id}">
            ${item.name}
          </div>
        `).join('')
      })
  }

  select(event) {
    const id = event.target.dataset.id
    this.inputTarget.value = event.target.textContent.trim()
    this.resultsTarget.innerHTML = ""

    const type = this.inputTarget.dataset.autocompleteType || "students"
    const fieldName = type === "institutions" ? "institution_id" : "student_id"

    const hiddenInput = this.element.querySelector(`input[type="hidden"][name*="[${fieldName}]"]`)
    if (hiddenInput) hiddenInput.value = id
  }

  handleClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.resultsTarget.innerHTML = ""
    }
  }
}
