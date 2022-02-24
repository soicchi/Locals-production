export default ({ $auth, route, redirect, store }) => {
  const loggedInUserNotAccess = ['/auth/signin', '/auth/signup']
  if ($auth.loggedIn && loggedInUserNotAccess.includes(route.path)) {
    store.dispatch('message/setMessages', { messages: ['すでにログインしています'], type: 'error' })
    return redirect('/')
  }
}
