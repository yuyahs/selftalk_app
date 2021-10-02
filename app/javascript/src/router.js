import { createRouter, createWebHistory } from "vue-router"
import Home from './pages/Home.vue'
import Show from './users/Show.vue'
import New from './users/New.vue'


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
    }
  ],
})
