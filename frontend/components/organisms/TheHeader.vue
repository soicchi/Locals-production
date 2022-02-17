<template>
  <div>
    <AtomsAppBarNavDrawer
      :drawer.sync="drawer"
      :drawer-menu-list="drawerMenuList"
    />
    <MoleculesAppBar
      :drawer="drawer"
      :drawer-menu-list="drawerMenuList"
      :account-menu-list="accountMenuList"
      :logged-in-user="loggedInUser"
      @signOut="signOut"
    >
      <template #nav-icon>
        <v-app-bar-nav-icon @click="drawer = !drawer" />
      </template>
    </MoleculesAppBar>
  </div>
</template>

<script>
export default {
  data () {
    return {
      drawer: false,
    }
  },
  computed: {
    loggedInUser () {
      return this.$store.getters['user/loggedInUser']
    },
    drawerMenuList () {
      return [
        {
          title: 'すべての投稿',
          to: '/posts/all',
          icon: 'mdi-note-multiple',
        },
        {
          title: '保存した投稿',
          to: '/posts/bookmark',
          icon: 'mdi-pin',
        },
        {
          title: '投稿',
          to: '/posts/create',
          icon: 'mdi-note-edit',
        },
        {
          title: 'マイページ',
          to: `/users/${this.loggedInUser.id}`,
          icon: 'mdi-account',
        },
      ]
    },
    accountMenuList () {
      return [
        {
          title: 'アカウント設定',
          to: '/users/edit',
          icon: 'mdi-account-cog',
        },
        {
          title: 'パスワード設定',
          to: '/users/password',
          icon: 'mdi-lock-outline',
        },
      ]
    },
  },
  methods: {

    async signOut () {
      if (window.confirm('ログアウトしてよろしいですか')) {
        await this.$auth.logout()
          .then((res) => {
            localStorage.removeItem('token-type')
            localStorage.removeItem('uid')
            localStorage.removeItem('client')
            localStorage.removeItem('access-token')
            this.$store.dispatch('user/resetLoggedInUser')
            const message = ['ログアウトしました']
            this.$store.dispatch('message/setMessages', { messages: message, type: 'success' })
            this.$router.push('/auth/signin')
          })
      }
    },
    changeDrawer () {
      this.drawer = !this.drawer
    },
  },
}
</script>
