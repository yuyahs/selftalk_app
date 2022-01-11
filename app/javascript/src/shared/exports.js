import { store } from '../store.js';
import { router } from '../router';

//不正なユーザーのアクセスを制限
function mksureCorrectUser(paramsId) {
  const currentUserId = store.state.userId
      if(!(currentUserId == paramsId)){
        router.push({name: 'home'})
      }
}

//ゲストユーザーのアクセスを制限
function mksureNotGuestUser() {
  if(store.state.guest){
    router.push({name: 'home'})
  }
}

export default {
  mksureCorrectUser,
  mksureNotGuestUser
};
