export default ({ $auth, route, redirect, store }) => {
  const loggedInUserAccess = ['/', '/auth/signin', '/auth/signup']
  if (!$auth.loggedIn && !loggedInUserAccess.includes(route.path)) {
    store.dispatch('message/setMessages', { messages: ['ログインが必要です'], type: 'error' })
    return redirect('/auth/signin')
  }
}
