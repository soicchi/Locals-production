<template>
  <v-radio-group
    label='性別'
    v-model='setGender'
    prepend-icon='mdi-human-male-female'
    row
    :rules='rules'
  >
    <v-radio
      label='男'
      value='man'
    ></v-radio>
    <v-radio
      label='女'
      value='woman'
    ></v-radio>
  </v-radio-group>
</template>

<script>
export default {
  props: {
    gender: {
      type: String,
      required: true
    }
  },
  computed: {
    rules() {
      return [
        v => !!v || ''
      ]
    },
    setGender: {
      get() { return this.gender },
      set(newVal) { return this.$emit('update:gender', newVal) }
    }
  }
}
</script>