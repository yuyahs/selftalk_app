// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@smartweb/vue-flash-message")
require("@rails/activestorage").start()
require("channels")
// 追加

import { createApp } from "vue";
import App from "../src/App.vue";
import { router } from '../src/router';
import FlashMessage from '@smartweb/vue-flash-message';

document.addEventListener("DOMContentLoaded", () => {
  const app = createApp(App);
  app.use(router);
  app.use(FlashMessage);
  app.mount("#application");
});



// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
