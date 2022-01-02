import { createRouter, createWebHistory } from "vue-router"
import { store } from './store.js';
import Home from './pages/Home.vue'
import About from './pages/About.vue'
import Contact from './pages/Contact.vue'
import Policy from './pages/Policy.vue'
import MyPage from './users/MyPage.vue'
import Signup from './users/Signup.vue'
import Login from './sessions/Login.vue'
import Reset from './password_resets/New.vue'
import Change from './password_resets/Edit.vue'
import userEdit from './users/Edit.vue'
import Courses from './answers/Courses.vue'
import Answers from './answers/Index.vue'
import AnswerEdit from './answers/Edit.vue'
import Questions from './questions/Admin.vue'
import Dictionary from './dictionaries/Dictionary.vue'
import Notices from './notices/Index.vue'
import Notice from './notices/Notice.vue'
import Error from './pages/Error.vue'

export const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
      meta: { title: 'Home' }
    },
    {
      path: '/about',
      name: 'about',
      component: About,
      meta: { title: 'About' }
    },
    {
      path: '/contacts',
      name: 'contact',
      component: Contact,
      meta: { title: 'お問い合わせ' }
    },
    {
      path: '/policy',
      name: 'policy',
      component: Policy,
      meta: { title: '利用規約' }
    },
    {
      path: '/users/:id',
      name: 'myPage',
      component: MyPage,
      meta: { title: 'MyPage' },
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next()
        else next({name: 'login'})
      }
    },
    {
      path: '/users/new',
      name: 'new',
      component: Signup,
      meta: { title: '新規登録' },
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next({name: 'home'})
        else next()
      }
    },
    {
      path: '/users/:id/edit',
      name: 'change info',
      component: userEdit,
      meta: { title: '登録情報変更' },
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next()
        else next({name: 'login'})
      }
    },
    {
      path: '/login',
      name: 'login',
      component: Login,
      meta: { title: 'ログイン' },
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next({name: 'home'})
        else next()
      }
    },
    {
      path: '/password_resets/new',
      name: 'reset',
      component: Reset,
      meta: { title: 'パスワードリセット' },
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next({name: 'home'})
        else next()
      }
    },
    {
      path: '/password_resets/:reset_token/edit',
      name: 'change',
      component: Change,
      meta: { title: 'パスワード再設定' },
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next({name: 'home'})
        else next()
      }
    },
    {
      path: '/course',
      name: 'courses',
      component: Courses,
      meta: { title: 'SelfTalk コース'},
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next()
        else next({name: 'login'})
      }
    },
    {
      path: '/users/:id/answers',
      name: 'answers',
      component: Answers,
      meta: { title: '回答一覧'},
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next()
        else next({name: 'login'})
      }
    },
    {
      path: '/users/:user_id/answers/:id/edit',
      name: 'answerEdit',
      component: AnswerEdit,
      meta: { title: '回答添削' },
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next()
        else next({name: 'login'})
      }
    },
    {
      path: '/admin_page',
      name: 'adminPage',
      component: Questions,
      meta: { title: '管理者用ページ' },
      beforeEnter: (to, from, next) => {
        if (store.state.admin) next()
        else next({name: 'home'})
      }
    },
    {
      path: '/users/:id/dictionaries',
      name: 'dictionary',
      component: Dictionary,
      meta: { title: 'My単語帳' },
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next()
        else next({name: 'login'})
      }
    },
    {
      path: '/notices',
      name: 'notices',
      component: Notices,
      meta: { title: 'お知らせ一覧'},
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next()
        else next({name: 'login'})
      }
    },
    {
      path: '/notices/:id',
      name: 'notice',
      component: Notice,
      meta: { title: 'お知らせ'},
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next()
        else next({name: 'login'})
      }
    },
    {
      path: '/404NotFound',
      name: 'Error',
      component: Error,
      meta: { title: 'Page Not Found'}
    }
  ],
})
