import Vue from 'vue'
import Vuex from 'vuex'
import { getStorage, setStorage, removeStorage } from './storage.js'
Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    currentUser: getStorage('currentUser') ? getStorage('currentUser') : {
      user_id: null,
      user_name: '',
      user_password: '',
      user_gender: '',
      user_phone: '',
      user_role: null
    },
    authorization: ''
  },
  getters: {
    getuser (state) {
      let user = getStorage('currentUser')
      state.user = user
      return state.user
    }

  },
  mutations: {
    setuser (state, payload) {
      state.currentUser = payload.user
      setStorage('currentUser', payload.user)
    },
    removeuser (state) {
      state.user = {
        user_id: null,
        user_name: '',
        user_password: '',
        user_gender: '',
        user_phone: '',
        user_role: null
      }
      removeStorage('currentUser')
    }
  },
  actions: {

  }

})

export default store
