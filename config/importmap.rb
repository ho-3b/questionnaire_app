# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "vue", to: "vue--dist--vue.esm-browser.js.js" # @3.3.4
# pin "vue/dist/vue.esm-browser.js", to: "vue--dist--vue.esm-browser.js.js" # @3.3.4
pin_all_from "app/javascript/controllers", under: "controllers"
