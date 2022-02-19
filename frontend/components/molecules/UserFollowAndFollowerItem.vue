<template>
  <div class="d-flex">
    <v-col cols="5">
      <AtomsUserIcon
        :icon-size="iconSize"
        :avatar-url="user.avatar_url"
      />
    </v-col>
    <v-col
      cols="5"
      align-self="center"
    >
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
