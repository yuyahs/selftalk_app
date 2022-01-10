import { store } from '../store.js';
import { router } from '../router';

function mksureCorrectUser(paramsId) {
  const currentUserId = store.state.userId
      if(!(currentUserId == paramsId)){
        router.push({name: 'home'})
      }
}

function mksureNotGuestUser() {
  if(store.state.guest){
    router.push({name: 'home'})
  }
}

export default {
  mksureCorrectUser,
  mksureNotGuestUser
};
