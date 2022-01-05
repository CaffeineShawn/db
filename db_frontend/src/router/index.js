import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../components/Home.vue'
import UserInfo from '../components/UserInfo.vue'
import OrderInfo from '../components/OrderInfo.vue'
import Login from '../components/Login.vue'
import { getStorage } from '../store/storage.js'

Vue.use(VueRouter)
// 挂载路由导航守卫

const router = new VueRouter({
  routes: [
    {
      path: '/',
      name: 'Login',
      component: Login
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

router.beforeEach((to, from, next) => {
  // to将要访问
  // 从哪访问
  // next接着干的事情next(url)重定向到url上，如果为空next()继续访问to路径
  if (to.path === '/login' || to.path === '/') return next()
  // 获取user
  const user = getStorage('currentUser')
  if (!user) return next('/login')
  next()
})

export default router
