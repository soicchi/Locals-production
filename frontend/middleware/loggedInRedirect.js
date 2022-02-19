export default ({ $auth, route, redirect }) => {
  const loggedInUserNotAccess = ['/auth/signin', '/auth/signup']
  if ($auth.loggedIn && loggedInUserNotAccess.includes(route.path)) {
    return redirect('/')
  }
}
