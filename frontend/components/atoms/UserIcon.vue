<template>
<div>
  <v-avatar v-if='!avatarUrl'>
    <v-icon
      :size='iconSize'
    >
      mdi-account-circle
    </v-icon>
  </v-avatar>
  <v-avatar
    v-else
    :size='iconSize'
  >
    <v-img :src='avatarUrl'/>
  </v-avatar>
</div>
</template>

<script>
export default {
  props: {
    iconSize: {
      type: Number,
      required: true
    },
    avatarUrl: {
      type: String,
      default: null
    }
  }
}
</script>