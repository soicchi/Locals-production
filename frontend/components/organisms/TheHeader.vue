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
            {{ mdiMenu }}
          </v-icon>
        </v-app-bar-nav-icon>
      </template>
    </MoleculesAppBar>
  </div>
</template>

<script>
import { mdiNoteEdit, mdiNoteMultiple, mdiPin, mdiAccount, mdiAccountCog, mdiLockOutline, mdiMenu } from '@mdi/js'

export default {
  data: () => ({
    drawer: false,
    mdiNoteEdit,
    mdiNoteMultiple,
    mdiAccount,
    mdiPin,
    mdiAccountCog,
    mdiLockOutline,
    mdiMenu,
  }),
  computed: {
    loggedInUser () {
      return this.$store.getters['user/loggedInUser']
    },
    drawerMenuList () {
      return [
        {
          title: '投稿',
          to: '/posts/create',
          icon: this.mdiNoteEdit,
        },
        {
          title: 'すべての投稿',
          to: '/posts/all',
          icon: this.mdiNoteMultiple,
        },
        {
          title: '保存した投稿',
          to: '/posts/bookmark',
          icon: this.mdiPin,
        },
        {
          title: 'マイページ',
          to: `/users/${this.loggedInUser.id}`,
          icon: this.mdiAccount,
        },
      ]
    },
    accountMenuList () {
      return [
        {
          title: 'アカウント設定',
          to: '/users/edit',
          icon: this.mdiAccountCog,
        },
        {
          title: 'パスワード設定',
          to: '/users/password',
          icon: this.mdiLockOutline,
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
