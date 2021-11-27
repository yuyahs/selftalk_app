
import  { createStore } from 'vuex'
import createPersistedState from 'vuex-persistedstate'

export const store = createStore ({
  state() {
    return {
      loggedIn: false,
      admin: false,
      notGuest: true,
      guest: false,
      userId: 0,
    }
  },
  mutations: {
    //ログイン状態にする
    login: (state) => {
      state.loggedIn = true;
    },
    //ログアウトする
    logout: (state)=> {
      state.loggedIn = false;
      state.admin = false;
      state.notGuest = true;
      state.guest = false;
    },
    //user.idをいつでも取り出せるように保存する
    setId: (state, id) => {
      state.userId = id
    },
    //保存したuser.idを削除する
    removeId: (state) => {
      state.userId = 0
    },
    //管理者権限を与える
    admin: (state) => {
      state.admin = true
    },
    //ゲストユーザーではないことを示す
    notGuest: (state) => {
      state.notGuest = false
    },
    //ゲストユーザーであることを示す
    inGuest: (state) => {
      state.guest = true
    }
  },
  plugins : [
    createPersistedState(),
  ],
})

