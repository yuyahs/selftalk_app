
import  { createStore } from 'vuex'
import createPersistedState from 'vuex-persistedstate'

export const store = createStore ({
  state() {
    return {
      loggedIn: false,
      userId: 0
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
    },
    setId: (state, id) => {
      localStorage.setItem('Id', id)
      state.userId = id
    }
  },
  plugins : [
    createPersistedState(),
  ],
})

