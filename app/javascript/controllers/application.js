import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
// application.debug = false
// window.Stimulus   = application
//
// export { application }
import * as Vue from "vue";

const App = Vue.createApp({
    data(){
        return {
            text: 'ああああああああああああああああああ',
            items: ['aaaaaa', 'bbbbb', 'ccc']
        }
    },
})

App.mount("#app");