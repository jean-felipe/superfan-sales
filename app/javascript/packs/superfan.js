import Vue from 'vue';
import humps from 'humps';
import VueSwal from 'vue-swal'

import Main from '../components/Main/Main.vue';
// import ActionCableVue from 'actioncable-vue';
// import "../assets/scss/index.scss";


const parseData = (prop) => {
  try {
    return JSON.parse(prop);
  } catch (e) {
    return prop;
  }
};

Vue.use(VueSwal)
// Vue.use(ActionCableVue, {
//   debug: true,
//   debugLevel: 'error',
//   connectionUrl: 'ws://3.20.18.9//cable'
// });


const init = () => {
  const element = document.getElementById('dashboard');
  if (element !== null) {
    const rawData = Object.assign({}, element.dataset);
    const propsData = Object.keys(rawData).reduce((acc, prop) => {
      acc[prop] = parseData(rawData[prop]);
      return acc;
    }, {});

    // eslint-disable-next-line no-new
    new Vue({
      el: element,
      render(h) {
        return h(Main, {
          props: propsData,
        });
      },
    });
  }
};

['DOMContentLoaded', 'page:load', 'page:restore'].forEach((event) => {
  document.addEventListener(event, init);
});
