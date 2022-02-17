export default ({ $axios }) => {
  $axios.onRequest((config) => {
    console.log(config)
  })
  $axios.onResponse((config) => {
    console.log(config)
  })
  $axios.onError((e) => {
    console.log(e.response)
  })
}
  