
import  { createStore } from 'vuex'
import createPersistedState from 'vuex-persistedstate'

export const store = createStore ({
  state() {
    return {
      loggedIn: false,
      admin: false,
      userId: 0,
    }
  },
  mutations: {
    login: (state, token) => {
      localStorage.setItem('Token', token);
      state.loggedIn = true;
    },
    logout: (state)=> {
      localStorage.removeItem('Token');
      state.loggedIn = false;
      state.admin = false;
    },
    setId: (state, id) => {
      state.userId = id
    },
    removeId: (state) => {
      state.userId = 0
    },
    admin: (state) => {
      state.admin = true
    }

  },
  plugins : [
    createPersistedState(),
  ],
})

