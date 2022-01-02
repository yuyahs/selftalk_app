export default {
  install (app) {
    //Course.vueで使用するタイマー。ページ遷移時に裏でタイマーが作動し続けるのを防ぐ。
    app.config.globalProperties.$intervals = []
    app.config.globalProperties.$setInterval = (func, intervalMilliSec) => {
      const timerId = setInterval(() => {
        func()
      }, intervalMilliSec)
      app.config.globalProperties.$intervals.push(timerId)
      return timerId
    }
    app.config.globalProperties.$clearInterval = (timerId) => {
      clearInterval(timerId)
      app.config.globalProperties.$intervals =[]

    }
    app.config.globalProperties.$clearAllIntervals = () => {
      app.config.globalProperties.forEach(clearInterval)
      app.config.globalProperties.$intervals = []
    }
  }
}
