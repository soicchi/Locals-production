<template>
  <v-btn
    text
    plain
    :to="`/users/${user.id}`"
    color="fontColor"
    :style="{'font-size': '15px'}"
  >
    {{ user.name }}
  </v-btn>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      required: true,
    },
  },
}
</script>
