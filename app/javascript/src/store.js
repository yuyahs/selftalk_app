
import  { createStore } from 'vuex'

export const store = createStore ({
  state() {
    return {
      loggedIn: false

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
    }
  },
})
