import colors from 'vuetify/es5/util/colors'

export default {
  server: {
    port: 80,
    host: '0.0.0.0',
  },
  // Disable server-side rendering: https://go.nuxtjs.dev/ssr-mode
  ssr: false,

  // Global page headers: https://go.nuxtjs.dev/config-head
  head: {
    title: "Local's",
    htmlAttrs: {
      lang: 'ja',
    },
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: '' },
      { name: 'format-detection', content: 'telephone=no' },
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
    ],
  },

  // Global CSS: https://go.nuxtjs.dev/config-css
  css: [
  ],

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: [
    '~/plugins/axios',
    { src: '~/plugins/localStorage.js', ssr: false },
    { src: '~/plugins/vue-awesome-swiper.js', ssr: false },
  ],

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
    // https://go.nuxtjs.dev/vuetify
    '@nuxtjs/vuetify',
    '@nuxtjs/date-fns',
    '@aceforth/nuxt-optimized-images',
  ],

  dateFns: [
    { locales: ['ja'] },
    { methods: ['format'] },
  ],

  optimizedImages: {
    optimizeImages: true,
    optimizeImagesInDev: true,
  },

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: [
    '@nuxtjs/axios',
    '@nuxtjs/auth',
  ],

  axios: {
    baseURL: process.env.NODE_ENV === 'production' ? 'https://local-s-app.com:3000/api/v1' : 'http://localhost:3000/api/v1',
  },

  router: {
    // 未認証時、ホーム画面にリダイレクトされる際にメッセージ表示機能実装予定
    middleware: [
      'loggedInRedirect',
    ],
  },

  auth: {
    redirect: {
      login: '/auth/signin',
      logout: '/auth/signin',
      callback: false,
      home: '/',
    },
    strategies: {
      local: {
        endpoints: {
          login: { url: '/auth/sign_in', method: 'post', propertyName: 'access-token' },
          logout: { url: '/auth/sign_out', method: 'delete' },
          user: false,
        },
      },
    },
  },

  // Vuetify module configuration: https://go.nuxtjs.dev/config-vuetify
  vuetify: {
    customVariables: ['~/assets/variables.scss'],
    treeShake: true,
    theme: {
      dark: false,
      themes: {
        light: {
          primary: colors.blue.darken2,
          accent: colors.grey.darken3,
          secondary: colors.amber.darken3,
          info: colors.teal.lighten1,
          warning: colors.amber.base,
          error: '#c65252',
          success: '#83c652',
          mainColor: '#ef6f4d',
          baseColor: '#fef9ef',
          subColor: '#672f21',
          fontColor: '#58554e',
          borderColor: '#e0dfdd',
          backgroundColor: '#abaaa6',
        },
      },
    },
  },

  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {
    vender: [
      'vue-awesome-swiper',
    ],
  },

  publicRuntimeConfig: {
    googleApiKey: process.env.GOOGLE_API_KEY,
  },
}
