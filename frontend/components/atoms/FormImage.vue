<template>
  <v-file-input
    multiple
    accept="image/png, image/jpeg, image/jpeg, image/gif"
    placeholder="料理やお店の写真"
    label="写真"
    :rules="rules"
    show-size
    persistent-hint
    prepend-icon="mdi-camera"
    hint="写真10枚まで、5MB未満まで"
    @change="setImages"
  />
</template>

<script>
export default {
  props: {
    images: {
      type: Array,
      required: true,
    },
  },
  computed: {
    rules () {
      return [
        v => !!v || '画像を添付してください',
      ]
    },
  },
  methods: {
    setImages (e) {
      this.$emit('update:images', e)
    },
  },
}
</script>
