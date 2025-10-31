import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="offcanvas"
export default class extends Controller {
  connect() {
    (() => {
      'use strict'
      document.querySelector('#navbarSideCollapse').addEventListener('click', () => {
        document.querySelector('.offcanvas-collapse').classList.toggle('open')
      })
    })()
  }
}
