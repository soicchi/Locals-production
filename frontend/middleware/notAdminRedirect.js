export default ({ store, redirect, route }) => {
  const loggedInUser = store.getters['user/loggedInUser']
  const notAdminNotAccess = ['/admin']
  if (!loggedInUser.admin && notAdminNotAccess.includes(route.path)) {
    const message = ['管理者でないとアクセスできません']
    store.dispatch('message/setMessages', { messages: message, type: 'error' })
    return redirect('/')
  }
}