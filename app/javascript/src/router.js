import { createRouter, createWebHistory } from "vue-router"
import Home from './pages/Home.vue'
import Show from './users/Show.vue'
import New from './users/New.vue'
import Login from './sessions/New.vue'
import Reset from './password_resets/New.vue'
import Change from './password_resets/Edit.vue'



export const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
    },
    {
      path: '/users/1',
      name: 'show',
      component: Show,
    },
    {
      path: '/users/new',
      name: 'new',
      component: New,
    },
    {
      path: '/login',
      name: 'login',
      component: Login,
    },
    {
      path: '/password_resets/new',
      name: 'reset',
      component: Reset,
    },
    {
      path: '/password_resets/:reset_token/edit',
      name: 'change',
      component: Change,
    },
    {
      path: '/api/account_activation/:activation_token/edit',
      redirect: '/',
      name: 'activation',
      component: Home
    }
  ],
})
