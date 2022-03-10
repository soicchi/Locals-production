<template>
  <div class="d-flex justify-center align-center">
    <v-text-field
      v-model="setCategory"
      label="カテゴリー追加"
      hint="追加したいカテゴリー入力"
    />
    <v-btn
      class="ml-3 white--text"
      rounded
      color="mainColor"
      @click="addCategory"
    >
      追加
    </v-btn>
  </div>
</template>

<script>
export default {
  props: {
    category: {
      type: String,
      required: true,
    },
  },
  computed: {
    setCategory: {
      get () { return this.category },
      set (newVal) { return this.$emit('update:category', newVal) },
    },
  },
  methods: {
    addCategory () {
      this.$emit('add-category')
    },
  },
}
</script>
