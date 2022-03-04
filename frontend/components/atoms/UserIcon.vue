<template>
  <div>
    <v-avatar
      v-if="!avatarUrl"
      :size="iconSize"
    >
      <v-icon
        :size="iconSize"
      >
        {{ mdiAccountCircle }}
      </v-icon>
    </v-avatar>
    <v-avatar
      v-else
      :size="iconSize"
    >
      <v-img :src="`${avatarUrl}?webp`" />
    </v-avatar>
  </div>
</template>

<script>
import { mdiAccountCircle } from '@mdi/js'

export default {
  props: {
    iconSize: {
      type: Number,
      required: true,
    },
    avatarUrl: {
      type: String,
      default: null,
    },
  },
  data: () => ({
    mdiAccountCircle,
  }),
}
</script>
