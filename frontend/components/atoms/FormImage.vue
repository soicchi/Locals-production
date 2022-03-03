<template>
  <v-file-input
    multiple
    accept="image/png, image/jpeg, image/jpeg, image/gif"
    placeholder="料理やお店の写真"
    label="写真"
    :rules="rules"
    show-size
    persistent-hint
    :prepend-icon="mdiCamera"
    hint="写真10枚まで、20MB未満まで"
    @change="setImages"
  />
</template>

<script>
import { mdiCamera } from '@mdi/js'

export default {
  props: {
    images: {
      type: Array,
      required: true,
    },
  },
  data: () => ({
    mdiCamera,
  }),
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
