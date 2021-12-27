import Vue from 'vue'
import Router from 'vue-router'
import Composition from '../components/Composition.vue'
import Home from '../components/Home.vue'
import UserInfo from '../components/UserInfo.vue'
import OrderInfo from '../components/OrderInfo.vue'
import Login from '../components/Login.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Composition',
      component: Composition
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
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
