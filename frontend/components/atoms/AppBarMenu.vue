<template>
  <v-menu
    app
    offset-x
    offset-y
    max-width="200"
  >
    <template #activator="{ on }">
      <v-btn
        icon
        v-on="on"
      >
        <v-icon size="40">
          mdi-account-circle
        </v-icon>
      </v-btn>
    </template>
    <v-list dense>
      <v-subheader>
        ログイン中のユーザー
      </v-subheader>
      <v-list-item>
        <v-list-item-content>
          <v-list-item-subtitle>
            {{ loggedInUser.name }}
          </v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
      <v-divider />
      <v-subheader>
        アカウント
      </v-subheader>
      <v-list-item-group>
        <template v-for="(menu, i) in accountMenuList">
          <v-list-item
            :key="`menu-item-${i}`"
            :to="menu.to"
          >
            <v-list-item-icon>
              <v-icon
                size="22"
                v-text="menu.icon"
              />
            </v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title>
                {{ menu.title }}
              </v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </template>
        <v-divider />
        <v-list-item @click="signOut">
          <v-list-item-icon>
            <v-icon>
              mdi-logout-variant
            </v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title>
              ログアウト
            </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list-item-group>
    </v-list>
  </v-menu>
</template>

<script>
export default {
  props: {
    accountMenuList: {
      type: Array,
      required: true,
    },
    loggedInUser: {
      type: Object,
      required: true,
    },
  },
  methods: {
    signOut () {
      this.$emit('signOut')
    },
  },
}
</script>
