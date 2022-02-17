export default ({ $axios }) => {
  $axios.onRequest((config) => {
    config.headers['access-token'] = window.localStorage.getItem('access-token')
    config.headers['token-type'] = window.localStorage.getItem('token-type')
    config.headers.uid = window.localStorage.getItem('uid')
    config.headers.client = window.localStorage.getItem('client')
    // eslint-disable-next-line no-console
    console.log(config)
  })
  $axios.onResponse((config) => {
    if (config.headers.client) {
      localStorage.setItem('access-token', config.headers['access-token'])
      localStorage.setItem('token-type', config.headers['token-type'])
      localStorage.setItem('uid', config.headers.uid)
      localStorage.setItem('client', config.headers.client)
    }
    // eslint-disable-next-line no-console
    console.log(config)
  })
  $axios.onError((e) => {
    // eslint-disable-next-line no-console
    console.log(e.response)
  })
}
