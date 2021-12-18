import Vue from 'vue'
import Router from 'vue-router'
import Composition from '../components/Composition.vue'
Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Composition',
      component: Composition
    }
  ]
})
