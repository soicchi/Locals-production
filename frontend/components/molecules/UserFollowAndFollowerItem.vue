<template>
  <div class="d-flex">
    <v-col
      cols="10"
      class="d-flex align-center"
    >
      <AtomsUserIcon
        :icon-size="iconSize"
        :avatar-url="user.avatar_url"
      />
      <AtomsUserName :user="user" />
    </v-col>
  </div>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      required: true,
    },
    iconSize: {
      type: Number,
      required: true,
    },
  },
}
</script>
