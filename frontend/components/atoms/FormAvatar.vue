<template>
  <v-file-input
    accept="image/png, image/gif, image/jpeg, image/jpg"
    label="プロフィール画像"
    :prepend-icon="mdiAccountCircle"
    @change="setAvatar"
  />
</template>

<script>
import { mdiAccountCircle } from '@mdi/js'

export default {
  props: {
    avatar: {
      type: String,
      required: true,
    },
  },
  data: () => ({
    mdiAccountCircle,
  }),
  methods: {
    setAvatar (e) {
      this.$emit('update:avatar', e)
    },
  },
}
</script>
