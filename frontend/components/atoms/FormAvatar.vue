<template>
  <v-file-input
    accept="image/png, image/gif, image/jpeg, image/jpg"
    label="プロフィール画像"
    @change="setAvatar"
  />
</template>

<script>
export default {
  props: {
    avatar: {
      type: String,
      required: true,
    },
  },
  methods: {
    setAvatar (e) {
      this.$emit('update:avatar', e)
    },
  },
}
</script>
