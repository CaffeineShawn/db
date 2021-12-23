import Vue from 'vue'
import Router from 'vue-router'
import Composition from '../components/Composition.vue'
import Home from '../components/Home.vue'
import UserInfo from '../components/UserInfo.vue'
import OrderInfo from '../components/OrderInfo.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Composition',
      component: Composition
    },
    {
      path: '/home',
      name: 'Home',
      component: Home,
      children: [
        {
          name: 'User',
          path: '/user',
          component: UserInfo
        },
        {
          name: 'Order',
          path: '/order',
          component: OrderInfo
        }
      ]
    }
  ]
})
