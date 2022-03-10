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
        <v-icon
          size="30"
          color="fontColor"
        >
          mdi-dots-vertical
        </v-icon>
      </v-btn>
    </template>
    <v-list dense>
      <v-list-item-group>
        <v-list-item @click="destroyPost">
          <v-list-item-icon>
            <v-icon size="22">
              mdi-trash-can-outline
            </v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title>
              投稿を削除
            </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-list-item @click="destroyUser">
          <v-list-item-icon>
            <v-icon size="22">
              mdi-account-remove-outline
            </v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title>
              ユーザーを削除
            </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list-item-group>
    </v-list>
  </v-menu>
</template>

<script>
export default {
  methods: {
    destroyPost () {
      this.$emit('destroy-post')
    },
    destroyUser () {
      this.$emit('destroy-user')
    },
  },
}
</script>
