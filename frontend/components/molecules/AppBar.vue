<template>
  <v-app-bar
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
  methods: {
    signOut () {
      this.$emit('signOut')
    },
  },
}
</script>
