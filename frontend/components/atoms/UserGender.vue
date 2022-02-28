<template>
  <span>
    <v-icon
      v-if="gender === 'woman'"
      color="red"
    >
      mdi-gender-female
    </v-icon>
    <v-icon
      v-else
      color="blue"
    >
      mdi-gender-male
    </v-icon>
  </span>
</template>

<script>
export default {
  props: {
    gender: {
      type: String,
      required: true,
    },
  },
}
</script>
