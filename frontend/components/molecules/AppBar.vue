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
      <v-spacer />
      <!-- 運用する場合適用 -->
      <!-- <template v-if="loggedInUser.admin"> -->
      <v-toolbar-items>
        <v-btn
          color="white"
          text
          to="/admin"
        >
          管理
        </v-btn>
      </v-toolbar-items>
      <!-- </template> -->
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
  },
  computed: {
    myPage () {
      return this.$route.path === `/users/${this.loggedInUser.id}` || this.$route.path === '/users/password' || this.$route.path === '/users/edit'
    },
  },
  methods: {
    signOut () {
      this.$emit('signOut')
    },
  },
}
</script>
