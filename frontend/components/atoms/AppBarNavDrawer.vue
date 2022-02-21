<template>
  <v-navigation-drawer
    v-model="setDrawer"
    app
    clipped
    height="auto"
    mobile-breakpoint="960"
    color="subColor"
  >
    <v-list>
      <v-list-item>
        <v-list-item-content>
          <v-list-item-title class="nav-menu">
            メニュー
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-divider />
      <v-list-item
        v-for="(menu, i) in drawerMenuList"
        :key="i"
        exact
        :to="menu.to"
      >
        <v-list-item-icon>
          <v-icon
            color="white"
            v-text="menu.icon"
          />
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title class="nav-menu">
            {{ menu.title }}
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
    <v-divider />
  </v-navigation-drawer>
</template>

<script>
export default {
  props: {
    drawer: {
      type: Boolean,
      required: true,
      default: false,
    },
    drawerMenuList: {
      type: Array,
      required: true,
    },
  },
  computed: {
    setDrawer: {
      get () { return this.drawer },
      set (newVal) { return this.$emit('update:drawer', newVal) },
    },
  },
}
</script>

<style lang="sass" scoped>
  .nav-menu
    color: #fff
</style>
