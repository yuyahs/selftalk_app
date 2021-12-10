import { createApp } from "vue";
import App from "../src/App.vue";
import { router } from '../src/router';
import FlashMessage from '@smartweb/vue-flash-message';
import { store } from '../src/store.js';
import SetInterval from '../src/plugins/SetInterval';



document.addEventListener("DOMContentLoaded", () => {
  const app = createApp(App);
  app.use(router);
  app.use(store);
  app.use(FlashMessage);
  app.use(SetInterval);
  app.mount("#application");
});
