<template>
  <div>
    <v-app-bar
      v-if="$vuetify.breakpoint.xs"
      color="mainColor"
      fixed
      app
      dense
      dark
      elevation="1"
      clipped-left
    >
      <slot name="nav-icon" />
      <v-toolbar-items>
        <AtomsAppBarTitle />
      </v-toolbar-items>
      <v-spacer />
      <AtomsAppBarMenu
        :account-menu-list="accountMenuList"
        :logged-in-user="loggedInUser"
        @signOut="signOut"
      />
    </v-app-bar>
    <v-app-bar
      v-else
      color="mainColor"
      fixed
      app
      dense
      elevation="1"
    >
      <v-toolbar-items>
        <AtomsAppBarTitle />
      </v-toolbar-items>
      <v-toolbar-items>
        <v-switch
          v-model="setAdmin"
          class="pt-3 ml-2"
          :label="mode"
          flat
          inset
          color="white"
        />
      </v-toolbar-items>
      <v-spacer />
      <v-toolbar-items v-if="loggedInUser.admin">
        <v-btn
          text
          color="white"
          retain-focus-on-click
          to="/admin"
        >
          管理
        </v-btn>
      </v-toolbar-items>
      <v-toolbar-items>
        <v-row
          justify="end"
          align="center"
        >
          <v-col
            cols="10"
            class="d-flex justify-end"
          >
            <v-btn
              v-for="(list, i) in drawerMenuList"
              :key="i"
              :to="list.to"
              text
              color="white"
              retain-focus-on-click
            >
              {{ list.title }}
            </v-btn>
            <v-btn
              color="white"
              text
              @click="signOut"
            >
              ログアウト
            </v-btn>
          </v-col>
        </v-row>
      </v-toolbar-items>
      <AtomsAppBarMenu
        v-if="myPage"
        :account-menu-list="accountMenuList"
        :logged-in-user="loggedInUser"
        @signOut="signOut"
      />
    </v-app-bar>
  </div>
</template>

<script>
export default {
  props: {
    drawerMenuList: {
      type: Array,
      required: true,
    },
    accountMenuList: {
      type: Array,
      required: true,
    },
    loggedInUser: {
      type: Object,
      required: true,
    },
    admin: {
      type: Boolean,
      required: true,
      default: false,
    },
  },
  computed: {
    myPage () {
      return this.$route.path === `/users/${this.loggedInUser.id}` || this.$route.path === '/users/password' || this.$route.path === '/users/edit'
    },
    setAdmin: {
      get () { return this.admin },
      set (newVal) { return this.$emit('update:admin', newVal) },
    },
    mode () {
      return this.admin ? '管理者' : 'ユーザー'
    },
  },
  methods: {
    signOut () {
      this.$emit('signOut')
    },
  },
}
</script>
