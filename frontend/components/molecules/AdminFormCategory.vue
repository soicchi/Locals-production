<template>
  <div class="d-flex justify-center align-center">
    <v-text-field
      v-model="setCategory"
      label="カテゴリー"
      hint="追加したいカテゴリー入力"
    />
    <v-btn
      @click="addCategory"
      class="ml-3 add-btn"
      rounded
      color="mainColor"
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
      default: '',
    }
  },
  computed: {
    setCategory: {
      get () { return this.category },
      set (newVal) { return this.$emit('update:category', newVal) },
    }
  },
  methods: {
    addCategory () {
      this.$emit('add-category')
    }
  }
}
</script>

<style lang="sass" scoped>
  .add-btn
    font-color: white
</style>