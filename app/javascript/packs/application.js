// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

class RowElement extends HTMLTableRowElement {
    connectedCallback() {
        this.addEventListener('click', this.onClick)
        this.style='cursor: pointer'
    }

    onClick(e) {
        const $target = $(e.target)
        if ( $target.closest('a').length > 0 ||
            $target.is('.btn') ||
            $target.is('input') ||
            $target.is('select') ||
            $target.is('.best_in_place') ||
            $target.closest('.project-actions').length > 0 )
        {
            return
        }

        e.preventDefault()

        if (this.dataset.hrefTarget) {
            window.open(this.dataset.href, this.dataset.hrefTarget)
        } else {
            window.location = this.dataset.href
        }
    }
}

document.addEventListener("DOMContentLoaded", function(){
    customElements.define('dapi-tr', RowElement, {extends: 'tr'});
});
