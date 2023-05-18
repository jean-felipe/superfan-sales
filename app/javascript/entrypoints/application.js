// To see this message, add the following to the `<head>` section in your
// views/layouts/application.html.erb
//
//    <%= vite_client_tag %>
//    <%= vite_javascript_tag 'application' %>
console.log('Vite ⚡️ Rails')

// If using a TypeScript entrypoint file:
//     <%= vite_typescript_tag 'application' %>
//
// If you want to use .jsx or .tsx, add the extension:
//     <%= vite_javascript_tag 'application.jsx' %>

console.log('Visit the guide for more information: ', 'https://vite-ruby.netlify.app/guide/rails')

// Example: Load Rails libraries in Vite.
//
// import * as Turbo from '@hotwired/turbo'
// Turbo.start()
//
// import ActiveStorage from '@rails/activestorage'
// ActiveStorage.start()
//
// // Import all channels.
// const channels = import.meta.globEager('./**/*_channel.js')

// Example: Import a stylesheet in app/frontend/index.css
// import '~/index.css'

import humps from 'humps';
import VueTheMask from 'vue-the-mask';

import VueMoment from 'vue-moment';

import Main from '../components/Main/Main.vue';
// import ActionCableVue from 'actioncable-vue';
// import "../assets/scss/index.scss";

import 'sweetalert2/dist/sweetalert2.min.css';

import { createApp } from 'vue';

const parseData = (prop) => {
  try {
    return JSON.parse(prop);
  } catch (e) {
    return prop;
  }
};

const element = document.getElementById('dashboard');
const rawData = Object.assign({}, element.dataset);
const propsData = Object.keys(rawData).reduce((acc, prop) => {
  acc[prop] = parseData(rawData[prop]);
  return acc;
}, {});

const app = createApp(Main, propsData);
app.mount('#dashboard');

app.use(VueTheMask);
app.use(VueMoment);

// Vue.use(ActionCableVue, {
//   debug: true,
//   debugLevel: 'error',
//   connectionUrl: 'ws://3.20.18.9//cable'
// });

app.filter('capitalize', function(value) {
  if (!value) return '';
  value = value.toString();
  return value.charAt(0).toUpperCase() + value.slice(1);
});
