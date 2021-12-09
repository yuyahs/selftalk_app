import { createRouter, createWebHistory } from "vue-router"
import { store } from './store.js';
import Home from './pages/Home.vue'
import About from './pages/About.vue'
import Contact from './pages/Contact.vue'
import Policy from './pages/Policy.vue'
import MyPage from './users/MyPage.vue'
import New from './users/New.vue'
import Login from './sessions/Login.vue'
import Reset from './password_resets/New.vue'
import Change from './password_resets/Edit.vue'
import userEdit from './users/Edit.vue'
import Courses from './answers/Courses.vue'
import Answers from './answers/Index.vue'
import AnswerEdit from './answers/Edit.vue'
import Questions from './questions/Admin.vue'
import Dictionary from './dictionaries/Dictionary.vue'
import Error from './pages/Error.vue'

export const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
    },
    {
      path: '/about',
      name: 'about',
      component: About
    },
    {
      path: '/contacts',
      name: 'contact',
      component: Contact
    },
    {
      path: '/policy',
      name: 'policy',
      component: Policy
    },
    {
      path: '/users/:id',
      name: 'myPage',
      component: MyPage,
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next()
        else next({name: 'login'})
      }
    },
    {
      path: '/users/new',
      name: 'new',
      component: New,
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next({name: 'home'})
        else next()
      }
    },
    {
      path: '/users/:id/edit',
      name: 'change info',
      component: userEdit,
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next()
        else next({name: 'login'})
      }
    },
    {
      path: '/login',
      name: 'login',
      component: Login,
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next({name: 'home'})
        else next()
      }
    },
    {
      path: '/password_resets/new',
      name: 'reset',
      component: Reset,
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next({name: 'home'})
        else next()
      }
    },
    {
      path: '/password_resets/:reset_token/edit',
      name: 'change',
      component: Change,
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next({name: 'home'})
        else next()
      }
    },
    {
      path: '/course',
      name: 'courses',
      component: Courses,
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next()
        else next({name: 'login'})
      }
    },
    {
      path: '/users/:id/answers',
      name: 'answers',
      component: Answers,
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next()
        else next({name: 'login'})
      }
    },
    {
      path: '/users/:user_id/answers/:id/edit',
      name: 'answerEdit',
      component: AnswerEdit,
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next()
        else next({name: 'login'})
      }
    },
    {
      path: '/admin_page',
      name: 'adminPage',
      component: Questions,
      beforeEnter: (to, from, next) => {
        if (store.state.admin) next()
        else next({name: 'home'})
      }
    },
    {
      path: '/users/:id/dictionaries',
      name: 'dictionary',
      component: Dictionary,
      beforeEnter: (to, from, next) => {
        if (store.state.loggedIn) next()
        else next({name: 'login'})
      }
    },
    {
      path: '/*',
      name: 'Error',
      component: Error
    }
  ],
})
