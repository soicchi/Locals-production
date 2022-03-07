<template>
  <div>
    <AtomsAppBarNavDrawer
      v-if="$vuetify.breakpoint.xs"
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
        <v-app-bar-nav-icon @click="drawer = !drawer">
          <v-icon>
            mdi-menu
          </v-icon>
        </v-app-bar-nav-icon>
      </template>
    </MoleculesAppBar>
  </div>
</template>

<script>
export default {
  data: () => ({
    drawer: false,
  }),
  computed: {
    loggedInUser () {
      return this.$store.getters['user/loggedInUser']
    },
    drawerMenuList () {
      return [
        {
          title: '投稿作成',
          to: '/posts/create',
          icon: 'mdi-note-edit',
        },
        {
          title: '投稿一覧',
          to: '/posts/following',
          icon: 'mdi-note-multiple',
        },
        {
          title: '保存した投稿',
          to: '/posts/bookmark',
          icon: 'mdi-pin',
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
        if (this.loggedInUser.guest === true) {
          this.$axios.delete('/auth')
        }
        await this.$auth.logout()
          .then((res) => {
            localStorage.removeItem('token-type')
            localStorage.removeItem('uid')
            localStorage.removeItem('client')
            localStorage.removeItem('access-token')
            this.$store.dispatch('user/resetLoggedInUser')
            const message = ['ログアウトしました']
            this.$store.dispatch('message/setMessages', { messages: message, type: 'success' })
          })
      }
    },
    changeDrawer () {
      this.drawer = !this.drawer
    },
  },
}
</script>
