
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
      unreadNotice: false
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
    //login中のユーザーのidを取り出せるようにする
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
    },
    //新着のお知らせを通知する
    notifyNotice: (state) => {
      state.unreadNotice = true
    },
    //お知らせ一覧ページを既読にする
    readNotice: (state) => {
      state.unreadNotice = false
    }
  },
  plugins : [
    createPersistedState(),
  ],
})

