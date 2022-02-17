<template>
  <v-card>
    <v-card-title>
      <slot name="modal-title" />
    </v-card-title>
    <v-card-actions>
      <slot name="modal-content" />
    </v-card-actions>
  </v-card>
</template>
