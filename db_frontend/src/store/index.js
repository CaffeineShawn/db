import Vue from 'vue'
import Vuex from 'vuex'
import { getStorage, setStorage, removeStorage } from './storage.js'
Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    user: {
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
      let user = getStorage('user')
      state.user = user
      return state.user
    }

  },
  mutations: {
    setuser (state, obj) {
      // state.user.userid = obj.userid || state.user.userid;
      // state.user.username = obj.username || state.user.username;
      // state.user.usernickname = obj.usernickname || state.user.usernickname;
      // state.user.userrole = obj.username.userrole || state.user.userrole;
      state.user = obj
      setStorage('user', obj)
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
      removeStorage('user')
    }
  },
  actions: {

  }

})

export default store
