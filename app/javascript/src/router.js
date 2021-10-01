import { createRouter, createWebHistory } from "vue-router"
import Home from './pages/Home.vue'
import Show from './users/Show.vue'
import HelloJSX from './components/helloJSX'

export const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
    },
    {
      path: '/jsx',
      name: 'jsx',
      component: HelloJSX,
    },
    {
      path: '/users/1',
      name: 'show',
      component: Show,
    },
  ],
})
