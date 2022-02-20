<template>
  <v-container fluid>
    <v-row
      align="center"
      justify="center"
    >
      <v-card
        width="55%"
        height="auto"
        elevation="1"
        class="my-5 pa-5"
      >
        <v-row align="center">
          <v-col cols="1">
            <AtomsUserIcon
              :icon-size="iconSize"
              :avatar-url="post.user.avatar_url"
            />
          </v-col>
          <v-col cols="2">
            <slot name="post-card-user-name" />
          </v-col>
          <v-spacer />
          <v-col
            cols="2"
            class="d-flex justify-center"
          >
            <AtomsCommonDate :date="post.created_at" />
          </v-col>
          <v-col
            v-if="$auth.loggedIn && !myPost"
            cols="2"
            class="d-flex justify-center"
          >
            <AtomsPostButtonBookMark
              :logged-in-user="loggedInUser"
              :post="post"
            />
          </v-col>
          <v-col
            v-if="$auth.loggedIn && myPost"
            cols="2"
            class="d-flex justify-center"
          >
            <AtomsPostButtonDestroy
              :post="post"
              @destroy-post="destroyPost"
            />
          </v-col>
        </v-row>
        <V-card-title>
          <AtomsPostRestaurantName :post="post" />
        </V-card-title>
        <v-row class="d-flex">
          <v-col
            cols="9"
            class="d-flex"
          >
            <v-sheet
              v-for="i in 3"
              :key="i"
              outlined
              width="200px"
              height="200px"
              class="mr-4"
            >
              <!-- <AtomsPostImage /> -->
            </v-sheet>
          </v-col>
          <v-col cols="3">
            <AtomsPostViews />
            <AtomsPostFavoriteRate :post="post" />
          </v-col>
        </v-row>
        <v-row class="d-flex justify-end">
          <v-col>
            <AtomsCategoryItem :categories="post.categories" />
          </v-col>
          <v-spacer />
        </v-row>
        <v-row
          justify="center"
          class="mb-5"
        >
          <AtomsPostButtonDetail :post-id="post.id" />
        </v-row>
      </v-card>
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    post: {
      type: Object,
      required: true,
    },
    loggedInUser: {
      type: Object,
      required: true,
    },
    iconSize: {
      type: Number,
      required: true,
    },
  },
  computed: {
    myPost () {
      return this.post.user_id === this.loggedInUser.id
    },
    // limitCount () {
    //   return this.post.image_url.slice(0, 3)
    // },
  },
  methods: {
    destroyPost () {
      this.$emit('destroy-post', this.post)
    },
  },
}
</script>
