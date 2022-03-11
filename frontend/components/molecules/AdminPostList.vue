<template>
  <v-card
    outlined
    width="100%"
    class="pa-5 mb-3"
  >
    <v-row align="center">
      <v-col
        cols="7"
        class="d-flex align-center"
      >
        <AtomsUserIcon
          :icon-size="iconSize"
          :avatar-url="post.user.avatar_url"
        />
        <AtomsUserName :user="post.user" />
        <AtomsCommonDistanceToNow :date="post.created_at" />
      </v-col>
      <v-spacer />
      <v-col
        cols="3"
        class="d-flex justify-end"
      >
        <MoleculesAdminMenu
          @destroy-post="destroyPost"
          @destroy-user="destroyUser"
        />
      </v-col>
    </v-row>
    <v-row>
      <v-col
        v-for="(image, i) in post.image_url"
        :key="i"
        cols="4"
        sm="3"
      >
        <v-sheet
          outlined
          width="80%"
          height="80%"
        >
          <AtomsPostImage :image="image" />
        </v-sheet>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12" class="py-0">
        <p>＜コメント＞</p>
      </v-col>
      <v-col cols="12" class="py-0">
        <AtomsPostComment :post="post" />
      </v-col>
    </v-row>
  </v-card>
</template>

<script>
export default {
  props: {
    post: {
      type: Object,
      required: true,
    },
    iconSize: {
      type: Number,
      required: true,
    },
  },
  methods: {
    destroyPost () {
      this.$emit('destroy-post')
    },
    destroyUser () {
      this.$emit('destroy-user')
    },
  },
}
</script>
