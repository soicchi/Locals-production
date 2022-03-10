<template>
  <v-dialog
    v-model="setDialog"
    width="30%"
  >
    <v-card>
      <v-card-title>
        <p>お知らせ</p>
      </v-card-title>
      <v-card-text>
        管理機能は現在ポートフォリオ公開に合わせて一時的にすべてのユーザーで使用可能にしています。
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    dialog: {
      type: Boolean,
      required: true,
      default: true,
    },
  },
  computed: {
    setDialog: {
      get () { return this.dialog },
      set (newVal) { return this.$emit('update:dialog', newVal) },
    },
  },
}
</script>
