// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import './plugins/element.js'
import axios from 'axios'
import store from './store/index'
/* eslint-disable no-new */

// 添加全局样式
import './assets/global.css'

// 屏蔽生产环境提示
Vue.config.productionTip = false

// 挂载axios
Vue.prototype.$http = axios

// axios默认路径
axios.defaults.baseURL = 'http://localhost:8085'

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
